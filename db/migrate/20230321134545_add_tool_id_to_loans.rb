class AddToolIdToLoans < ActiveRecord::Migration[7.0]
  def change
    add_reference :loans, :tool, foreign_key: true
  end
end
