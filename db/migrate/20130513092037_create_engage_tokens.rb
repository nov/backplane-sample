class CreateEngageTokens < ActiveRecord::Migration
  def change
    create_table :engage_tokens do |t|

      t.timestamps
    end
  end
end
