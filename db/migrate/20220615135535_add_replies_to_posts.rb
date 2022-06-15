class AddRepliesToPosts < ActiveRecord::Migration[6.1]
  def change
    add_reference :posts, :post
  end
end
