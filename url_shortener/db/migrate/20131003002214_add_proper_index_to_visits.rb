class AddProperIndexToVisits < ActiveRecord::Migration
  def change
    add_index(:visits, :shortened_id)
  end
end
