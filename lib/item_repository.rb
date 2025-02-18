require_relative 'database_connection'
require_relative 'item'
class ItemRepository
  def all
    sql = 'SELECT id, item_name, unit_price, item_quantity, order_id FROM items;'
    result_set = DatabaseConnection.exec_params(sql, [])
    items(result_set)
  end

  def items(result)
    items = []
    result.each do |record|
      item = Item.new
      item.id = record['id']
      item.item_name = record['item_name']
      item.unit_price = record['unit_price']
      item.item_quantity = record['item_quantity']
      item.order_id = record['order_id']
      items << item
    end 
    return items
  end

  def create(item)
    sql = 'INSERT INTO items (item_name, unit_price, item_quantity, order_id)  VALUES ($1, $2, $3, $4);'
    sql_params = [item.item_name, item.unit_price, item.item_quantity, item.order_id]
    result_set = DatabaseConnection.exec_params(sql, sql_params)
  end
end
