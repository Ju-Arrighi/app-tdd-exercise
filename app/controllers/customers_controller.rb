class CustomersController < ApplicationController
  before_action :set_customer, only: %i[show edit update]
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
  end

  def edit
  end

  def update
    if @customer.update(customer_params)
      redirect_to customers_path(customer_params[:id]), notice: 'Client updated successfully'
    else
      render edit_customer_path
    end
  end

  private

  def set_customer
    @customer = Customer.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(:id, :name, :email, :telephone, :avatar, :smoke)
  end
end
