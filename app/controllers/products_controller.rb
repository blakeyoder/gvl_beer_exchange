class ProductsController < ApplicationController
  @@client = SquareConnect.new

  def index
    @products = Product.limit(25)
    @order_item = current_order.order_items.new
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    @product.save
  end

  private
  def product_params
    params.require(:product).permit(:name, :price, :active)
  end
  
end
