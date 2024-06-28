=begin
+ There's a dental office called Dental People Inc.  
+ Within this office, there's 2 oral surgeons, 2 orthodontists, 1 general dentist.
+ Both general dentists and oral surgeons can pull teeth. 
+ Orthodontists cannot pull teeth.  
+ Orthodontists straighten teeth.
+ All of these aforementioned specialties are dentists. 
+ All dentists graduated from dental school.  
+ Oral surgeons place implants.
+ General dentists fill teeth

+ * Dental Office
  + - named Dental People Inc

  + - 2 oral surgeons

  + - 2 orthodontists

  + - 1 general dentist

+ * Dentist
  + - graduated from dental school

+ * Oral surgeon (speciality of dentist)
  + - can pull teeth
  + - place implants

+ * Orthodontist (speciality of dentist)
  + - can straighten teeth

+ * General Dentist (speciality of dentist)
  + - can pull teeth
  + - fill teeth
=end

module Pullable
  def pull_teeth
    "I can pull teeth"
  end
end

class Dentist
  def graduated
    "I graduated from Dental School"
  end
end

class OralSurgeon < Dentist
  include Pullable

  def place_implants
    "I can place dental implants"
  end
end

class Orthodontist < Dentist
  def straighten_teeth
    "I can straighten teeth"
  end
end

class GeneralDentist < Dentist
  include Pullable

  def fill_teeth
    "I can fill teeth"
  end
end

class DentalOffice
  attr_reader :oral_surgeons, :orthodontists, :general_dentists

  def initialize
    @oral_surgeons = []
    @orthodontists = []
    @general_dentists = []
  end

  def add_oral_surgeon(oral_surgeon)
    @oral_surgeons << oral_surgeon
  end

  def add_orthodontist(orthodontist)
    @orthodontists << orthodontist
  end

  def add_general_dentist(general_dentist)
    @general_dentists << general_dentist
  end
end

dental_people_inc = DentalOffice.new

oral_surg1 = OralSurgeon.new
oral_surg2 = OralSurgeon.new

ortho1 = Orthodontist.new
ortho2 = Orthodontist.new

general_dent = GeneralDentist.new

dental_people_inc.add_oral_surgeon(oral_surg1)
dental_people_inc.add_oral_surgeon(oral_surg2)
dental_people_inc.add_orthodontist(ortho1)
dental_people_inc.add_orthodontist(ortho2)
dental_people_inc.add_general_dentist(general_dent)

p dental_people_inc.oral_surgeons
p dental_people_inc.orthodontists
p dental_people_inc.general_dentists





