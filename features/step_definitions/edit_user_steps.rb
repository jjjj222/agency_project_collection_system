When /^I go to the (?:edit user|user edit) (?:\s*page|)$/i do
  visit(edit_tamu_user_path current_user)
   # visit edit_tamu_user(current_user)
end
