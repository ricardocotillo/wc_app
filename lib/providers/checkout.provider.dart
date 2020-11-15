class CheckoutProvider {
  String address;
  String district;
  String name;
  String lastName;
  String idType;
  String idNum;
  String phone;
  String email;

  String getDistrictCode() => _districts[district];

  Map<String, String> _districts = {
    '070701': 'Callao',
    '070702': 'Bellavista',
    '070703': 'Carmen de La Legua',
    '070704': 'La Perla',
    '070705': 'La Punta',
    '070706': 'Mi Perú',
    '070707': 'Ventanilla',
    '150101': 'Cercado de Lima',
    '150102': 'Ancón',
    '150103': 'Ate',
    '150104': 'Barranco',
    '150105': 'Breña',
    '150106': 'Carabayllo',
    '150108': 'Chaclacayo',
    '150109': 'Chorrillos',
    '150107': 'Cieneguilla',
    '150110': 'Comas',
    '150111': 'El Agustino',
    '150112': 'Independencia',
    '150113': 'Jesús María',
    '150114': 'La Molina',
    '150115': 'La Victoria',
    '150116': 'Lince',
    '150117': 'Los Olivos',
    '150118': 'Lurigancho',
    '150119': 'Lurín',
    '150120': 'Magdalena del Mar',
    '150121': 'Miraflores',
    '150122': 'Pachacámac',
    '150123': 'Pucusana',
    '150124': 'Pueblo Libre',
    '150125': 'Puente Piedra',
    '150126': 'Punta Hermosa',
    '150127': 'Punta Negra',
    '150128': 'Rímac',
    '150129': 'San Bartolo',
    '150130': 'San Borja',
    '150131': 'San Isidro',
    '150132': 'San Juan de Lurigancho',
    '150133': 'San Juan de Miraflores',
    '150134': 'San Luis',
    '150135': 'San Martín de Porres',
    '150136': 'San Miguel',
    '150137': 'Santa Anita',
    '150138': 'Santa María del Mar',
    '150139': 'Santa Rosa',
    '150140': 'Santiago de Surco',
    '150141': 'Surquillo',
    '150142': 'Villa El Salvador',
    '150143': 'Villa María del Triunfo'
  };
}
