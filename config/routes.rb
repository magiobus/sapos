Sapos::Application.routes.draw do
  root :to => 'welcome#index'

  match 'estudiantes/busqueda' => 'students#live_search'
  match 'estudiantes/:id/cambiar_foto' => 'students#change_image'
  match 'estudiantes/upload_image' => 'students#upload_image'
  match 'estudiantes/:id/archivos' => 'students#files'
  match 'estudiantes/:id/archivo/:file_id' => 'students#file'
  match 'estudiantes/upload_file' => 'students#upload_file'
  match 'estudiantes/delete_file' => 'students#delete_file'
  match 'estudiantes/:id/nuevo_avance' => 'students#new_advance'
  match 'estudiantes/create_advance' => 'students#create_advance'

  resources :student_files

  match 'docentes/busqueda' => 'staffs#live_search'
  match 'docentes/:id/cambiar_foto' => 'staffs#change_image'
  match 'docentes/upload_image' => 'staffs#upload_image'

  match 'instituciones/busqueda' => 'institutions#live_search'
  match 'instituciones/:id/cambiar_logo' => 'institutions#change_image'
  match 'instituciones/upload_image' => 'institutions#upload_image'
 
  scope(:path_names => { :new => "nuevo", :edit => "editar" }) do
    resources :students, :path => "estudiantes"
    resources :staffs, :path => "docentes"
    resources :institutions, :path => "instituciones"
    resources :users, :path => "usuarios"
  end

  match '/auth/admin/callback', :to => 'sessions#authenticate'
end
