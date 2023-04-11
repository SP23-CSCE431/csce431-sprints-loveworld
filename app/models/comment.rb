class Comment < ApplicationRecord
    belongs_to  :post
    belongs_to  :parent, class_name: 'Comment', optional: true
  
    validates :body, presence: :true
  end
