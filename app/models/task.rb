class Task < ApplicationRecord
  belongs_to :user,optional: true

  enum status: {uncompleted: 0, completed: 1}


end
