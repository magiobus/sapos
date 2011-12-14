Sapos::Application.routes.draw do
  get "scholarship_categories/index"

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
  match 'estudiantes/:id/horario/:term_id' => 'students#schedule_table'

  resources :student_files

  match 'docentes/busqueda' => 'staffs#live_search'
  match 'docentes/:id/cambiar_foto' => 'staffs#change_image'
  match 'docentes/upload_image' => 'staffs#upload_image'
  match 'docentes/:id/seminarios' => 'staffs#seminars_table'
  match 'docentes/:id/nuevo_seminario' => 'staffs#new_seminar'
  match 'docentes/create_seminar' => 'staffs#create_seminar'
  match 'docentes/update_seminar' => 'staffs#update_seminar'
  match 'docentes/:id/seminario/:seminar_id' => 'staffs#edit_seminar'

  match 'internados/busqueda' => 'internships#live_search'
  match 'internados/:id/cambiar_foto' => 'internships#change_image'
  match 'internados/upload_image' => 'internships#upload_image'
  match 'internados/:id/archivos' => 'internships#files'
  match 'internados/:id/archivo/:file_id' => 'internships#file'
  match 'internados/upload_file' => 'internships#upload_file'
  match 'internados/delete_file' => 'internships#delete_file'

  resources :internship_files

  match 'instituciones/busqueda' => 'institutions#live_search'
  match 'instituciones/:id/cambiar_logo' => 'institutions#change_image'
  match 'instituciones/upload_image' => 'institutions#upload_image'

  match 'campus/busqueda' => 'campus#live_search'
  match 'campus/:id/cambiar_logo' => 'campus#change_image'
  match 'campus/upload_image' => 'campus#upload_image'

  match 'aulas/busqueda' => 'classrooms#live_search'
  
  match 'becas/busqueda' => 'scholarship_categories#live_search'
  match 'becas/:id/tipos' => 'scholarship_categories#types_table'
  match 'becas/:id/nuevo_tipo' => 'scholarship_categories#new_type'
  match 'becas/create_type' => 'scholarship_categories#create_type'
  match 'becas/update_type' => 'scholarship_categories#update_type'
  match 'becas/:id/tipo/:scholarship_type_id' => 'scholarship_categories#edit_type'
  match 'laboratorios/busqueda' => 'laboratories#live_search'
  match 'usuarios/busqueda' => 'users#live_search'
  
  match 'programas/busqueda' => 'programs#live_search'
  match 'programas/:id/nuevo_curso' => 'programs#new_course'
  match 'programas/create_course' => 'programs#create_course'
  match 'programas/:id/plan' => 'programs#plan_table'
  match 'programas/:id/curso/:course_id' => 'programs#edit_course'
  match 'programas/:id/periodos' => 'programs#terms_table'
  match 'programas/:id/nuevo_periodo' => 'programs#new_term'
  match 'programas/create_term' => 'programs#create_term'
  match 'programas/update_term' => 'programs#update_term'
  match 'programas/:id/periodo/:term_id' => 'programs#edit_term'
  match 'programas/:id/terms_dropdown' => 'programs#terms_dropdown'
  match 'programas/:id/periodo/:term_id/courses_dropdown' => 'programs#courses_dropdown'
  match 'programas/:id/periodo/:term_id/seleccionar_cursos' => 'programs#select_courses_for_term'
  match 'programas/:id/periodo/:term_id/asignar_cursos_al_periodo' => 'programs#assign_courses_to_term'
  match 'programas/:id/periodo/:term_id/curso/:course_id/horario' => 'programs#schedule_table'
  match 'programas/:id/periodo/:term_id/curso/:course_id/nueva_sesion' => 'programs#new_schedule'
  match 'programas/create_session' => 'programs#create_schedule'
  match 'programas/update_session' => 'programs#update_schedule'
  match 'programas/:id/periodo/:term_id/curso/:course_id/sesion/:term_course_schedule_id' => 'programs#edit_schedule'
  match 'programas/:id/periodo/:term_id/curso/:course_id/estudiantes' => 'programs#students_table'
  match 'programas/:id/periodo/:term_id/curso/:course_id/agregar_estudiante' => 'programs#new_course_student'
  match 'programas/create_course_student' => 'programs#create_course_student'
  match 'programas/update_course_student' => 'programs#update_course_student'
  match 'programas/:id/periodo/:term_id/curso/:course_id/estudiante/:term_course_student_id' => 'programs#edit_course_student'
  match 'programas/:id/periodo/:term_id/curso/:course_id/estudiante/:term_course_student_id/desactivar' => 'programs#inactive_course_student'
  match 'programas/:id/periodo/:term_id/inscripciones' => 'programs#enrollment_table'
  match 'programas/:id/periodo/:term_id/nueva_inscripcion' => 'programs#new_enrollment'
  match 'programas/:id/create_enrollment' => 'programs#create_enrollment'
  match 'programas/:id/update_enrollment' => 'programs#update_enrollment'
  match 'programas/:id/periodo/:term_id/inscripcion/:term_student_id' => 'programs#edit_enrollment'

  scope(:path_names => { :new => "nuevo", :edit => "editar" }) do
    resources :students, :path => "estudiantes"
    resources :staffs, :path => "docentes"
    resources :internships, :path => "internados"
    resources :programs, :path => "programas"
    resources :institutions, :path => "instituciones"
    resources :campus, :path => "campus"
    resources :classrooms, :path => "aulas"
<<<<<<< HEAD
=======
    resources :laboratories, :path => "laboratorios"
>>>>>>> original/master
    resources :scholarship_categories, :path => "becas"
    resources :users, :path => "usuarios"
  end

  match '/auth/admin/callback', :to => 'sessions#authenticate'
end
