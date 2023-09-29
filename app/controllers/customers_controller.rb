class CustomersController < ApplicationController
  def index
    @customers = Customer.all
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      redirect_to customers_path, notice: 'Saved new client successfully'
    else
      render new_customer_path
    end
  end

  def show
    @customer = Customer.find(params[:id])
  end
  private

  def customer_params
    params.require(:customer).permit(:id, :name, :email, :telephone, :avatar, :smoke)
  end
end
