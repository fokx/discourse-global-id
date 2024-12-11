# frozen_string_literal: true
class AddGlobalIdToPost < ActiveRecord::Migration[7.2]
  def change
    add_column :posts, :global_id, :string
  end
end
