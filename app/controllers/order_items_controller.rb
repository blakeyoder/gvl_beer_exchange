class OrderItemsController < ApplicationController

  def create
    @order = current_order
    if merge_items?(@order) != true
      @order_item = @order.order_items.new(order_item_params)
    end
    @order.save
    session[:order_id] = @order.id
  end

  def update
    @order = current_order
    @order_item = @order.order_items.find(params[:id])
    @order_item.update_attributes(order_item_params)
    @order_items = @order.order_items
  end

  def destroy
    @order = current_order
    @order_item = @order.order_items.find(params[:id])
    @order_item.destroy
    @order_items = @order.order_items
  end

  private
  def order_item_params
    params.require(:order_item).permit(:quantity, :product_id)
  end
  
  private
  def merge_items?(order)
    order.order_items.each do |oi|
      if (oi.product_id == params[:order_item][:product_id].to_i)
        oi.update_column(:quantity, oi.quantity + params[:order_item][:quantity].to_i)
        return true
      end
    end
  end

end
