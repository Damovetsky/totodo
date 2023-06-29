//Isar needs an id of type int and server of type string,
//so I desided to calculate isarId of string uuid to get a number up to 16^6
class intIdFromUuid {
  static int generate(String uuid) {
    return int.parse(uuid.substring(30), radix: 16);
  }
}
