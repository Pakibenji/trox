ActiveAdmin.register Tool do
    permit_params :title, :description, :pic, :location, :caution, :condition
  
    index do
      selectable_column
      id_column
      column :title
      column :description
      column :pic
      column :location
      column :caution
      column :condition
      actions
    end
  
    filter :title
    filter :description
    filter :location
  
    form do |f|
      f.inputs do
        f.input :title
        f.input :description
        f.input :pic
        f.input :location
        f.input :caution
        f.input :condition
      end
      f.actions
    end
  end