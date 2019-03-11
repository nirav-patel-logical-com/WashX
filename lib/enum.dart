
//Authorization enums
enum InputFieldTypes {
  DEFAULT,
  USERNAME_EMAIL_PHONE,
  PASSWORD,
  FIRST_NAME,
  LAST_NAME,
  EMAIL,
  PHONE,
  USERNAME
}


enum WashStatus { ENQUEUE, WASHING, DRYING, IRONING, OUTFORDELIEVERY }

enum TtsState { PLAYING, STOPPED }


///Item/Cloth enums
//Add you page to this enum for navigation purpose
enum PageType {
  HISTORY,
  WashDetails,
  WashOptions,
  HOMEPAGE,
  FREEWASH,
  BEFOREPAGE,
  WASHPAGE,
  WARDROBE,
  PAYMENTPAGE,
  WASHASSISTANTPAGE,
  WASH,
  LAUNDRY,
  ACCOUNT,
  CAREPREFRENCES,
  PREFRENCES,
  NEWITEM,
  GIFTWASH,
  HELPCENTER,
  CONTACT
}

//To get the cloth category
enum WashCategoryTypes {
  SHIRT,
  SUITE,
  TIE,
  PANTS,
  SKIRT,
  SLIPPERS,
  TROUSERS,
  T_SHIRT,
  JEANS,
}
//To get the color of clothes/items involved
enum WashColorTypes { BLUE, RED, GREEN, YELLOW, WHITE, BLACK, ORANGE }
//To categogize patterns of clothes/items
enum WashPattern {
  HOR_STRIPES,
  VER_STRIPES,
  HOR_ARROWS,
  VER_ARROWS,
}

//To select camera output typede
enum CameraType{
  PHOTO,
  LABEL,
  BARCODE
}
