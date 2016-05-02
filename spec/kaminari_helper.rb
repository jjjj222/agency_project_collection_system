module KaminariHelper
  def assign_paginated(variable, array, pg = 0)
    assign(variable, Kaminari.paginate_array(array).page(pg))
  end
end
