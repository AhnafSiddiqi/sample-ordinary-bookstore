module OrdersHelper

  def pending_order?
    user = current_user
    order_status = find_pending_order user
    order_status.present?
  end

  def current_order
    user = current_user
    order = find_pending_order user
    order[0]
  end

  def cancel_order(id)
    update_order_status(id, 'cancelled')
  end
end
