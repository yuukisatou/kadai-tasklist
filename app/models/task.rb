class Task < ApplicationRecord
  validates :content, presence: true, length: { maximum: 255 }
  
  #バリデーションチェック
  #・空っぽでないか
  #・255文字以内か
end
