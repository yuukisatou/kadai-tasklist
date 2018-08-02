class Task < ApplicationRecord
  
  belongs_to :user # UserとTaskの一対多
  
  validates :content, presence: true, length: { maximum: 255 }
  #バリデーションチェック content
  #・空っぽでないか
  #・255文字以内か
  
  validates :status, presence: true, length: {maximum: 10 }
  #バリデーションチェック status
  #・空っぽでないか
  #・10文字以内か
  
end
