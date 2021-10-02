class CreateTagRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :tag_relationships do |t|
      t.references :post_image, foreign_key: true
      t.references :tag, foreign_key: true

      t.timestamps
    end
    add_index :tag_relationships, [:post_image_id, :tag_id], unique: true
    # uniqueで同じ名前のタグが作れないように
  end
end
