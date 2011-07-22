class User < ActiveRecord::Base
  ADMINISTRATOR = 1
  OPERATOR      = 2
  STAFF         = 3
  STUDENT       = 4

  STATUS_ACTIVE   = 1
  STATUS_INACTIVE = 2

  ACCESS_TYPE = {STUDENT       => 'Estudiante',
                 STAFF         => 'Docente',
                 OPERATOR      => 'Operador',
                 ADMINISTRATOR => 'Administrador'}

  STATUS = {STATUS_INACTIVE => 'Inactivo',
            STATUS_ACTIVE   => 'Activo'}

  validates :email, :presence => true, :uniqueness => true
  validates :access, :presence => true

  def access_type
    ACCESS_TYPE[access]
  end
end
