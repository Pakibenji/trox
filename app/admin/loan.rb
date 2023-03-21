ActiveAdmin.register Loan do
    permit_params :start_date, :end_date
  
    index do
      selectable_column
      id_column
      column :start_date
      column :end_date
      actions
    end
  
    form do |f|
      f.inputs do
        f.input :start_date
        f.input :end_date
      end
      f.actions
    end
  end