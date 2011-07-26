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
  match 'estudiantes/asignar_numero_tesis' => 'students#assign_thesis_number'

  resources :student_files

  match 'docentes/busqueda' => 'staffs#live_search'
  match 'docentes/:id/cambiar_foto' => 'staffs#change_image'
  match 'docentes/upload_image' => 'staffs#upload_image'

  match 'instituciones/busqueda' => 'institutions#live_search'
  match 'instituciones/:id/cambiar_logo' => 'institutions#change_image'
  match 'instituciones/upload_image' => 'institutions#upload_image'

  match 'usuarios/busqueda' => 'users#live_search'
  
  match 'programas/busqueda' => 'programs#live_search'
  match 'programas/:id/nuevo_curso' => 'programs#new_course'
  match 'programas/create_course' => 'programs#create_course'
  match 'programas/update_course' => 'programs#update_course'
  match 'programas/:id/plan' => 'programs#plan_table'
  match 'programas/:id/curso/:course_id' => 'programs#edit_course'

  scope(:path_names => { :new => "nuevo", :edit => "editar" }) do
    resources :students, :path => "estudiantes"
    resources :staffs, :path => "docentes"
    resources :programs, :path => "programas"
    resources :institutions, :path => "instituciones"
    resources :users, :path => "usuarios"
  end

  match '/auth/admin/callback', :to => 'sessions#authenticate'
end
