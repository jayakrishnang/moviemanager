class CreateUserActivities < ActiveRecord::Migration
  def change
    create_table :user_activities do |t|
    	t.references :user
    	t.references :movie
    	t.string :activity, limit:30
      t.timestamps
    end
  end
end
