class TransactionsController < ApplicationController
  before_action :set_transaction, only: [:show, :edit, :update, :destroy]
  # linking module/concern to controller "include [nameOfModule]"
  include SaveCard
  # GET /transactions
  # GET /transactions.json
  def index
    @transactions = Transaction.all
  end

  # GET /transactions/1
  # GET /transactions/1.json
  def show
  end

  # GET /transactions/new
  def new
    @flight = Flight.find(params[:flight_id])
    @id = @flight.id
    @transaction = Transaction.new

  end

  # GET /transactions/1/edit
  def edit
  end

  # POST /transactions
  # POST /transactions.json
  def create
    @flight = Flight.find(transaction_params[:flight_id])
    # not sure why I need to tell it that flight_id is the flight_id?
    # Figured out why ^^ because I'm using this as a variable in my redirect paths (doh!)
    flight_id = transaction_params[:flight_id]
    @transaction = Transaction.new(transaction_params)
    price = transaction_params[:price]
    payment_token = transaction_params[:payment_token]

    # is transaction valid? 
    # is it a spreedly purchase? (else it is expedia)
    # process purchase, was successful? save transaction
    if @transaction.valid?
      if @transaction.expedia_purchase
        expedia_success = @transaction.expedia_pmd(@transaction)
        if expedia_success['transaction']['succeeded'] == true
          redirect_to flights_path, notice: 'Pack your bags! Your reservation was a success!'
        else
          redirect_to '/transactions/new?flight_number=' + flight_id, notice: 'Something went wrong.'
        end
      else
        spreedly_success = @transaction.spreedly_purchase(payment_token, price)
        # if the spreedly purchase succeeded
          if spreedly_success['transaction']['succeeded'] == true && @transaction.save
            if @transaction.retain_card
              @new_card = save_card(@transaction, spreedly_success)
              redirect_to transaction_path(@transaction.id), notice: 'Your card has been saved for future payments. Time to fly! Your ticket has been purchased.'
            else
              redirect_to transaction_path(@transaction.id), notice: 'Time to fly! Your ticket has been purchased.'
            end
          else
            redirect_to '/transactions/new?flight_number=' + flight_id, notice: 'Something went wrong.'
          end
        end
    else 
      render :new, alert: "Transaction not valid."
    end

  end

  # PATCH/PUT /transactions/1
  # PATCH/PUT /transactions/1.json
  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to @transaction, notice: 'Transaction was successfully updated.' }
        format.json { render :show, status: :ok, location: @transaction }
      else
        format.html { render :edit }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1
  # DELETE /transactions/1.json
  def destroy
    @transaction.destroy
    respond_to do |format|
      format.html { redirect_to transactions_url, notice: 'Transaction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def transaction_params
      params.require(:transaction).permit(:email, :flight_number, :price, :payment_token, :retain_card, :expedia_purchase, :flight_id)
    end
end
