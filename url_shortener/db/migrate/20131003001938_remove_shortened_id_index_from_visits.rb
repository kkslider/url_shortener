class RemoveShortenedIdIndexFromVisits < ActiveRecord::Migration
  def up
    remove_index(:visits, column: :shortened_id)
  end

  def down
  end
end
