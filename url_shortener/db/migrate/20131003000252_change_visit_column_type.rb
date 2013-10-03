class ChangeVisitColumnType < ActiveRecord::Migration
  def up
    change_column(:visits, :shortened_id, :integer, { unique: false})
  end

  def down
  end
end
