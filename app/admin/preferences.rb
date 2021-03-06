ActiveAdmin.register Preference do
  menu false

  index do
    column :name
    column :preference_type
    column 'Actions' do |q|
      link_to 'SHow', admin_preference_path(q)
    end
  end

  form do |f|
    f.inputs 'Details' do
      f.input :name
      f.input :preference_type, as: :select, collection: ['ADG', 'Profile']
    end
    f.actions
  end


end
