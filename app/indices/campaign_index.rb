ThinkingSphinx::Index.define :campaign, :with => :active_record do
  indexes title, :sortable => true
  indexes category.name, :as => :category
  
  has category_id
end