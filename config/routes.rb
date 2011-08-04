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

  match 'aulas/busqueda' => 'classrooms#live_search'

  match 'usuarios/busqueda' => 'users#live_search'
  
  match 'programas/busqueda' => 'programs#live_search'
  match 'programas/:id/nuevo_curso' => 'programs#new_course'
  match 'programas/create_course' => 'programs#create_course'
  match 'programas/:id/plan' => 'programs#plan_table'
  match 'programas/:id/curso/:course_id' => 'programs#edit_course'
  match 'programas/:id/periodos' => 'programs#terms_table'
  match 'programas/:id/nuevo_periodo' => 'programs#new_term'
  match 'programas/create_term' => 'programs#create_term'
  match 'programas/:id/periodo/:term_id' => 'programs#edit_term'
  match 'programas/:id/terms_dropdown' => 'programs#terms_dropdown'
  match 'programas/:id/periodo/:term_id/courses_dropdown' => 'programs#courses_dropdown'
  match 'programas/:id/periodo/:term_id/seleccionar_cursos' => 'programs#select_courses_for_term'
  match 'programas/:id/periodo/:term_id/asignar_cursos_al_periodo' => 'programs#assign_courses_to_term'
  match 'programas/:id/periodo/:term_id/curso/:course_id/horario' => 'programs#schedule_table'
  match 'programas/:id/periodo/:term_id/curso/:course_id/nueva_sesion' => 'programs#new_schedule'
  match 'programas/create_session' => 'programs#create_schedule'
  match 'programas/:id/periodo/:term_id/curso/:course_id/sesion/:term_course_schedule_id' => 'programs#edit_schedule'
  match 'programas/:id/periodo/:term_id/curso/:course_id/estudiantes' => 'programs#students_table'
  match 'programas/:id/periodo/:term_id/curso/:course_id/agregar_estudiante' => 'programs#new_course_student'
  match 'programas/create_course_student' => 'programs#create_course_student'
  match 'programas/:id/periodo/:term_id/inscripciones' => 'programs#enrollment_table'
  match 'programas/:id/periodo/:term_id/nueva_inscripcion' => 'programs#new_enrollment'
  match 'programas/:id/create_enrollment' => 'programs#create_enrollment'

  scope(:path_names => { :new => "nuevo", :edit => "editar" }) do
    resources :students, :path => "estudiantes"
    resources :staffs, :path => "docentes"
    resources :programs, :path => "programas"
    resources :institutions, :path => "instituciones"
    resources :classrooms, :path => "aulas"
    resources :users, :path => "usuarios"
  end

  match '/auth/admin/callback', :to => 'sessions#authenticate'
end
