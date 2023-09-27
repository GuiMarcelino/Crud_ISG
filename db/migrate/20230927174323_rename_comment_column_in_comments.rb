class RenameCommentColumnInComments < ActiveRecord::Migration[7.0]
  def change
    rename_column :comments, :comment, :description
  end
end
