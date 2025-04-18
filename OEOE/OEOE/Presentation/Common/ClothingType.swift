//
//  ClothingType.swift
//  OEOE
//
//  Created by 송우진 on 4/19/25.
//

enum ClothingType: String, CaseIterable {
    // 👕 상의
    case topTShirtShort = "TOP_TSHIRT_SHORT"      // 반팔 티셔츠
    case topTShirtLong = "TOP_TSHIRT_LONG"        // 긴팔 티셔츠
    case topSweatshirt = "TOP_SWEATSHIRT"         // 맨투맨
    case topHoodie = "TOP_HOODIE"                 // 후드 티셔츠
    case topShirt = "TOP_SHIRT"                   // 셔츠
    case topPolo = "TOP_POLO"                     // 카라 티셔츠/폴로
    case topKnit = "TOP_KNIT"                     // 니트/스웨터
    case topSleeveless = "TOP_SLEEVELESS"         // 민소매/나시

    // 🧥 아우터
    case outerHoodieZip = "OUTER_HOODIE_ZIP"         // 후드 집업
    case outerBomber = "OUTER_BOMBER"                // 항공점퍼(블루종)
    case outerLeather = "OUTER_LEATHER"              // 가죽 재킷
    case outerCardigan = "OUTER_CARDIGAN"            // 카디건
    case outerDenim = "OUTER_DENIM"                  // 데님 재킷
    case outerBlazer = "OUTER_BLAZER"                // 정장 재킷/블레이저
    case outerStadium = "OUTER_STADIUM"              // 스타디움 재킷
    case outerWindbreaker = "OUTER_WINDBREAKER"      // 바람막이/윈드브레이커
    case outerAnorak = "OUTER_ANORAK"                // 아노락
    case outerTraining = "OUTER_TRAINING"            // 트레이닝 자켓
    case outerLightCoat = "OUTER_LIGHT_COAT"         // 가벼운 코트
    case outerSafari = "OUTER_SAFARI"                // 사파리 재킷
    case outerVest = "OUTER_VEST"                    // 조끼/베스트
    case outerShortPadding = "OUTER_SHORT_PADDING"   // 숏패딩
    case outerMustang = "OUTER_MUSTANG"              // 무스탕
    case outerFleece = "OUTER_FLEECE"                // 플리스
    case outerCoat = "OUTER_COAT"                    // 코트
    case outerLongPadding = "OUTER_LONG_PADDING"     // 롱패딩
    case outerPaddingVest = "OUTER_PADDING_VEST"     // 패딩 조끼

    // 👖 바지
    case bottomJeans = "BOTTOM_JEANS"             // 청바지/데님
    case bottomJogger = "BOTTOM_JOGGER"           // 트레이닝/조거 팬츠
    case bottomCotton = "BOTTOM_COTTON"           // 면바지
    case bottomSlacks = "BOTTOM_SLACKS"           // 정장 바지/슬랙스
    case bottomShorts = "BOTTOM_SHORTS"           // 반바지
    case bottomLeggings = "BOTTOM_LEGGINGS"       // 레깅스
    case bottomJumpsuit = "BOTTOM_JUMPSUIT"       // 점프수트/오버올

    // 👗 원피스/스커트
    case onepieceDress = "ONEPIECE_DRESS"         // 원피스
    case onepieceSkirt = "ONEPIECE_SKIRT"         // 스커트

    // 👟 신발
    case shoesSneakers = "SHOES_SNEAKERS"         // 스니커즈/운동화
    case shoesWinter = "SHOES_WINTER"             // 방한화/털신
    case shoesBoots = "SHOES_BOOTS"               // 부츠
    case shoesFormal = "SHOES_FORMAL"             // 구두
    case shoesSandals = "SHOES_SANDALS"           // 샌들/슬리퍼
    case shoesSports = "SHOES_SPORTS"             // 스포츠화

    // 🧢 액세서리
    case accHat = "ACC_HAT"                       // 모자
    case accScarf = "ACC_SCARF"                   // 목도리/스카프
    case accSocks = "ACC_SOCKS"                   // 양말
    case accGlasses = "ACC_GLASSES"               // 선글라스/안경
}

extension ClothingType {
    var displayName: String {
        switch self {
        // 👕 상의
        case .topTShirtShort: return "반팔 티셔츠"
        case .topTShirtLong: return "긴팔 티셔츠"
        case .topSweatshirt: return "맨투맨"
        case .topHoodie: return "후드 티셔츠"
        case .topShirt: return "셔츠"
        case .topPolo: return "카라 티셔츠/폴로"
        case .topKnit: return "니트/스웨터"
        case .topSleeveless: return "민소매/나시"

        // 🧥 아우터
        case .outerHoodieZip: return "후드 집업"
        case .outerBomber: return "항공점퍼(블루종)"
        case .outerLeather: return "가죽 재킷"
        case .outerCardigan: return "카디건"
        case .outerDenim: return "데님 재킷"
        case .outerBlazer: return "정장 재킷/블레이저"
        case .outerStadium: return "스타디움 재킷"
        case .outerWindbreaker: return "바람막이/윈드브레이커"
        case .outerAnorak: return "아노락"
        case .outerTraining: return "트레이닝 자켓"
        case .outerLightCoat: return "가벼운 코트"
        case .outerSafari: return "사파리 재킷"
        case .outerVest: return "조끼/베스트"
        case .outerShortPadding: return "숏패딩"
        case .outerMustang: return "무스탕"
        case .outerFleece: return "플리스"
        case .outerCoat: return "코트"
        case .outerLongPadding: return "롱패딩"
        case .outerPaddingVest: return "패딩 조끼"

        // 👖 바지
        case .bottomJeans: return "청바지/데님"
        case .bottomJogger: return "트레이닝/조거 팬츠"
        case .bottomCotton: return "면바지"
        case .bottomSlacks: return "정장 바지/슬랙스"
        case .bottomShorts: return "반바지"
        case .bottomLeggings: return "레깅스"
        case .bottomJumpsuit: return "점프수트/오버올"

        // 👗 원피스/스커트
        case .onepieceDress: return "원피스"
        case .onepieceSkirt: return "스커트"

        // 👟 신발
        case .shoesSneakers: return "스니커즈/운동화"
        case .shoesWinter: return "방한화/털신"
        case .shoesBoots: return "부츠"
        case .shoesFormal: return "구두"
        case .shoesSandals: return "샌들/슬리퍼"
        case .shoesSports: return "스포츠화"

        // 🧢 액세서리
        case .accHat: return "모자"
        case .accScarf: return "목도리/스카프"
        case .accSocks: return "양말"
        case .accGlasses: return "선글라스/안경"
        }
    }
}
