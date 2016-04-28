#Reils on #profile and #params
module SortingHelper
  def sort_params(old_params, key)
    new_params = {sort: key}
    if old_params and old_params['sort'] == key.to_s
      new_params[:reverse] = true if not old_params['reverse']
    end
    new_params
  end
end
