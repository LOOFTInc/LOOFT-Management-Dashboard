enum DeviceTemplateUnits {
  none,
  degreeCelsius,
  degreeFahrenheit,
  kelvin,
  percent,
  meter,
  centimeter,
  millimeter,
  kilometer,
  inch,
  foot,
  yard,
  mile,
  meterPerSecond,
  kilometerPerHour,
  milePerHour,
  knot,
  meterPerSecondSquared,
  centimeterPerSecondSquared,
  gForce,
  radian,
  degreeOfArc,
  secondOfArc,
  turn,
  watt,
  kilowatt,
  horsepower,
  volt,
  ampere,
  milliAmpere,
  ohm,
  kiloOhm,
  megaOhm,
  farad,
  microfarad,
  nanofarad,
  picofarad,
  henry,
  millihenry,
  microhenry,
  nanohenry,
  picohenry,
  hertz,
  kilohertz,
  megahertz,
  gigahertz,
  terahertz,
  degreePerSecond,
  radianPerSecond,
  rpm,
  degreePerSecondSquared,
  radianPerSecondSquared,
  newton,
  kilogramForce,
  poundForce,
  kilogram,
  gram,
  milligram,
  pound,
  ounce,
  newtonMeter,
  joule,
  kilojoule,
  calorie,
  kilocalorie,
  wattHour,
  kilowattHour,
  ampereHour,
  milliampereHour,
  voltAmpere,
  kilovoltAmpere,
  voltAmpereReactive,
  kilovoltAmpereReactive,
  voltAmpereReactiveHour,
  kilovoltAmpereReactiveHour,
  voltAmpereHour,
  kilovoltAmpereHour,
}

extension DisplayName on DeviceTemplateUnits {
  /// Returns the display name of the unit
  String get displayName {
    switch (this) {
      case DeviceTemplateUnits.none:
        return 'None';
      case DeviceTemplateUnits.degreeCelsius:
        return 'Celsius (°C)';
      case DeviceTemplateUnits.degreeFahrenheit:
        return 'Fahrenheit (°F)';
      case DeviceTemplateUnits.kelvin:
        return 'Kelvin (K)';
      case DeviceTemplateUnits.percent:
        return 'Percent (%)';
      case DeviceTemplateUnits.meter:
        return 'Meter (m)';
      case DeviceTemplateUnits.centimeter:
        return 'Centimeter (cm)';
      case DeviceTemplateUnits.millimeter:
        return 'Millimeter (mm)';
      case DeviceTemplateUnits.kilometer:
        return 'Kilometer (km)';
      case DeviceTemplateUnits.inch:
        return 'Inch (in)';
      case DeviceTemplateUnits.foot:
        return 'Foot (ft)';
      case DeviceTemplateUnits.yard:
        return 'Yard (yd)';
      case DeviceTemplateUnits.mile:
        return 'Mile (mi)';
      case DeviceTemplateUnits.meterPerSecond:
        return 'Meter per second (m/s)';
      case DeviceTemplateUnits.kilometerPerHour:
        return 'Kilometer per hour (km/h)';
      case DeviceTemplateUnits.milePerHour:
        return 'Mile per hour (mi/h)';
      case DeviceTemplateUnits.knot:
        return 'Knot (kn)';
      case DeviceTemplateUnits.meterPerSecondSquared:
        return 'Meter per second squared (m/s²)';
      case DeviceTemplateUnits.centimeterPerSecondSquared:
        return 'Centimeter per second squared (cm/s²)';
      case DeviceTemplateUnits.gForce:
        return 'G-Force (G)';
      case DeviceTemplateUnits.radian:
        return 'Radian (rad)';
      case DeviceTemplateUnits.degreeOfArc:
        return 'Degree of arc (°)';
      case DeviceTemplateUnits.secondOfArc:
        return 'Second of arc (″)';
      case DeviceTemplateUnits.turn:
        return 'Turn (turn)';
      case DeviceTemplateUnits.watt:
        return 'Watt (W)';
      case DeviceTemplateUnits.kilowatt:
        return 'Kilowatt (kW)';
      case DeviceTemplateUnits.horsepower:
        return 'Horsepower (hp)';
      case DeviceTemplateUnits.volt:
        return 'Volt (V)';
      case DeviceTemplateUnits.ampere:
        return 'Ampere (A)';
      case DeviceTemplateUnits.milliAmpere:
        return 'Milli Ampere (mA)';
      case DeviceTemplateUnits.ohm:
        return 'Ohm (Ω)';
      case DeviceTemplateUnits.kiloOhm:
        return 'Kilo Ohm (kΩ)';
      case DeviceTemplateUnits.megaOhm:
        return 'Mega Ohm (MΩ)';
      case DeviceTemplateUnits.farad:
        return 'Farad (F)';
      case DeviceTemplateUnits.microfarad:
        return 'Micro Farad (µF)';
      case DeviceTemplateUnits.nanofarad:
        return 'Nano Farad (nF)';
      case DeviceTemplateUnits.picofarad:
        return 'Pico Farad (pF)';
      case DeviceTemplateUnits.henry:
        return 'Henry (H)';
      case DeviceTemplateUnits.millihenry:
        return 'Milli Henry (mH)';
      case DeviceTemplateUnits.microhenry:
        return 'Micro Henry (µH)';
      case DeviceTemplateUnits.nanohenry:
        return 'Nano Henry (nH)';
      case DeviceTemplateUnits.picohenry:
        return 'Pico Henry (pH)';
      case DeviceTemplateUnits.hertz:
        return 'Hertz (Hz)';
      case DeviceTemplateUnits.kilohertz:
        return 'Kilo Hertz (kHz)';
      case DeviceTemplateUnits.megahertz:
        return 'Mega Hertz (MHz)';
      case DeviceTemplateUnits.gigahertz:
        return 'Giga Hertz (GHz)';
      case DeviceTemplateUnits.terahertz:
        return 'Tera Hertz (THz)';
      case DeviceTemplateUnits.degreePerSecond:
        return 'Degree per second (°/s)';
      case DeviceTemplateUnits.radianPerSecond:
        return 'Radian per second (rad/s)';
      case DeviceTemplateUnits.rpm:
        return 'RPM (rpm)';
      case DeviceTemplateUnits.degreePerSecondSquared:
        return 'Degree per second squared (°/s²)';
      case DeviceTemplateUnits.radianPerSecondSquared:
        return 'Radian per second squared (rad/s²)';
      case DeviceTemplateUnits.newton:
        return 'Newton (N)';
      case DeviceTemplateUnits.kilogramForce:
        return 'Kilogram force (kgf)';
      case DeviceTemplateUnits.poundForce:
        return 'Pound force (lbf)';
      case DeviceTemplateUnits.kilogram:
        return 'Kilogram (kg)';
      case DeviceTemplateUnits.gram:
        return 'Gram (g)';
      case DeviceTemplateUnits.milligram:
        return 'Milligram (mg)';
      case DeviceTemplateUnits.pound:
        return 'Pound (lb)';
      case DeviceTemplateUnits.ounce:
        return 'Ounce (oz)';
      case DeviceTemplateUnits.newtonMeter:
        return 'Newton meter (Nm)';
      case DeviceTemplateUnits.joule:
        return 'Joule (J)';
      case DeviceTemplateUnits.kilojoule:
        return 'Kilojoule (kJ)';
      case DeviceTemplateUnits.calorie:
        return 'Calorie (cal)';
      case DeviceTemplateUnits.kilocalorie:
        return 'Kilocalorie (kcal)';
      case DeviceTemplateUnits.wattHour:
        return 'Watt hour (Wh)';
      case DeviceTemplateUnits.kilowattHour:
        return 'Kilowatt hour (kWh)';
      case DeviceTemplateUnits.ampereHour:
        return 'Ampere hour (Ah)';
      case DeviceTemplateUnits.milliampereHour:
        return 'Milli Ampere hour (mAh)';
      case DeviceTemplateUnits.voltAmpere:
        return 'Volt Ampere (VA)';
      case DeviceTemplateUnits.kilovoltAmpere:
        return 'Kilovolt Ampere (kVA)';
      case DeviceTemplateUnits.voltAmpereReactive:
        return 'Volt Ampere Reactive (VAR)';
      case DeviceTemplateUnits.kilovoltAmpereReactive:
        return 'Kilovolt Ampere Reactive (kVAR)';
      case DeviceTemplateUnits.voltAmpereReactiveHour:
        return 'Volt Ampere Reactive hour (VARh)';
      case DeviceTemplateUnits.kilovoltAmpereReactiveHour:
        return 'Kilovolt Ampere Reactive hour (kVARh)';
      case DeviceTemplateUnits.voltAmpereHour:
        return 'Volt Ampere hour (VAh)';
      case DeviceTemplateUnits.kilovoltAmpereHour:
        return 'Kilovolt Ampere hour (kVAh)';
    }
  }

  /// Returns the unit
  String get symbol {
    switch (this) {
      case DeviceTemplateUnits.none:
        return '';
      case DeviceTemplateUnits.degreeCelsius:
        return '°C';
      case DeviceTemplateUnits.degreeFahrenheit:
        return '°F';
      case DeviceTemplateUnits.kelvin:
        return 'K';
      case DeviceTemplateUnits.percent:
        return '%';
      case DeviceTemplateUnits.meter:
        return 'm';
      case DeviceTemplateUnits.centimeter:
        return 'cm';
      case DeviceTemplateUnits.millimeter:
        return 'mm';
      case DeviceTemplateUnits.kilometer:
        return 'km';
      case DeviceTemplateUnits.inch:
        return 'in';
      case DeviceTemplateUnits.foot:
        return 'ft';
      case DeviceTemplateUnits.yard:
        return 'yd';
      case DeviceTemplateUnits.mile:
        return 'mi';
      case DeviceTemplateUnits.meterPerSecond:
        return 'm/s';
      case DeviceTemplateUnits.kilometerPerHour:
        return 'km/h';
      case DeviceTemplateUnits.milePerHour:
        return 'mi/h';
      case DeviceTemplateUnits.knot:
        return 'kn';
      case DeviceTemplateUnits.meterPerSecondSquared:
        return 'm/s²';
      case DeviceTemplateUnits.centimeterPerSecondSquared:
        return 'cm/s²';
      case DeviceTemplateUnits.gForce:
        return 'G';
      case DeviceTemplateUnits.radian:
        return 'rad';
      case DeviceTemplateUnits.degreeOfArc:
        return '°';
      case DeviceTemplateUnits.secondOfArc:
        return '″';
      case DeviceTemplateUnits.turn:
        return 'turn';
      case DeviceTemplateUnits.watt:
        return 'W';
      case DeviceTemplateUnits.kilowatt:
        return 'kW';
      case DeviceTemplateUnits.horsepower:
        return 'hp';
      case DeviceTemplateUnits.volt:
        return 'V';
      case DeviceTemplateUnits.ampere:
        return 'A';
      case DeviceTemplateUnits.milliAmpere:
        return 'mA';
      case DeviceTemplateUnits.ohm:
        return 'Ω';
      case DeviceTemplateUnits.kiloOhm:
        return 'kΩ';
      case DeviceTemplateUnits.megaOhm:
        return 'MΩ';
      case DeviceTemplateUnits.farad:
        return 'F';
      case DeviceTemplateUnits.microfarad:
        return 'µF';
      case DeviceTemplateUnits.nanofarad:
        return 'nF';
      case DeviceTemplateUnits.picofarad:
        return 'pF';
      case DeviceTemplateUnits.henry:
        return 'H';
      case DeviceTemplateUnits.millihenry:
        return 'mH';
      case DeviceTemplateUnits.microhenry:
        return 'µH';
      case DeviceTemplateUnits.nanohenry:
        return 'nH';
      case DeviceTemplateUnits.picohenry:
        return 'pH';
      case DeviceTemplateUnits.hertz:
        return 'Hz';
      case DeviceTemplateUnits.kilohertz:
        return 'kHz';
      case DeviceTemplateUnits.megahertz:
        return 'MHz';
      case DeviceTemplateUnits.gigahertz:
        return 'GHz';
      case DeviceTemplateUnits.terahertz:
        return 'THz';
      case DeviceTemplateUnits.degreePerSecond:
        return '°/s';
      case DeviceTemplateUnits.radianPerSecond:
        return 'rad/s';
      case DeviceTemplateUnits.rpm:
        return 'rpm';
      case DeviceTemplateUnits.degreePerSecondSquared:
        return '°/s²';
      case DeviceTemplateUnits.radianPerSecondSquared:
        return 'rad/s²';
      case DeviceTemplateUnits.newton:
        return 'N';
      case DeviceTemplateUnits.kilogramForce:
        return 'kgf';
      case DeviceTemplateUnits.poundForce:
        return 'lbf';
      case DeviceTemplateUnits.kilogram:
        return 'kg';
      case DeviceTemplateUnits.gram:
        return 'g';
      case DeviceTemplateUnits.milligram:
        return 'mg';
      case DeviceTemplateUnits.pound:
        return 'lb';
      case DeviceTemplateUnits.ounce:
        return 'oz';
      case DeviceTemplateUnits.newtonMeter:
        return 'Nm';
      case DeviceTemplateUnits.joule:
        return 'J';
      case DeviceTemplateUnits.kilojoule:
        return 'kJ';
      case DeviceTemplateUnits.calorie:
        return 'cal';
      case DeviceTemplateUnits.kilocalorie:
        return 'kcal';
      case DeviceTemplateUnits.wattHour:
        return 'Wh';
      case DeviceTemplateUnits.kilowattHour:
        return 'kWh';
      case DeviceTemplateUnits.ampereHour:
        return 'Ah';
      case DeviceTemplateUnits.milliampereHour:
        return 'mAh';
      case DeviceTemplateUnits.voltAmpere:
        return 'VA';
      case DeviceTemplateUnits.kilovoltAmpere:
        return 'kVA';
      case DeviceTemplateUnits.voltAmpereReactive:
        return 'VAR';
      case DeviceTemplateUnits.kilovoltAmpereReactive:
        return 'kVAR';
      case DeviceTemplateUnits.voltAmpereReactiveHour:
        return 'VARh';
      case DeviceTemplateUnits.kilovoltAmpereReactiveHour:
        return 'kVARh';
      case DeviceTemplateUnits.voltAmpereHour:
        return 'VAh';
      case DeviceTemplateUnits.kilovoltAmpereHour:
        return 'kVAh';
    }
  }
}
