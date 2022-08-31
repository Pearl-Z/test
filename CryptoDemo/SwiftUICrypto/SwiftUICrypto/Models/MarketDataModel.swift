//
//  MarketDataModel.swift
//  SwiftUICrypto
//
//  Created by xcz on 2022/8/8.
//


// CoinGecko API info
/*
 URL: https://api.coingecko.com/api/v3/global
 
 JSON Response:
 {
   "data": {
     "active_cryptocurrencies": 13048,
     "upcoming_icos": 0,
     "ongoing_icos": 49,
     "ended_icos": 3376,
     "markets": 540,
     "total_market_cap": {
       "btc": 49144787.78582727,
       "eth": 659608704.3923205,
       "ltc": 18629600507.929314,
       "bch": 8086010533.887166,
       "bnb": 3617659968.015158,
       "eos": 927077095903.9325,
       "xrp": 3088658404739.787,
       "xlm": 8918769313392.885,
       "link": 137486244876.8335,
       "dot": 127691567217.16748,
       "yfi": 99802998.83606155,
       "usd": 1187856940782.6965,
       "aed": 4363057936341.873,
       "ars": 158655874724252.3,
       "aud": 1696829882769.2607,
       "bdt": 112446394985976.66,
       "bhd": 447924222371.983,
       "bmd": 1187856940782.6965,
       "brl": 6089667392616.559,
       "cad": 1525293837664.716,
       "chf": 1131202103992.063,
       "clp": 1080058923406662.9,
       "cny": 8026705705950.898,
       "czk": 28527571101980.25,
       "dkk": 8658513746326.872,
       "eur": 1163695930607.172,
       "gbp": 978908153471.2571,
       "hkd": 9324540381595.963,
       "huf": 457788055743979.25,
       "idr": 17616123681608156,
       "ils": 3931039118406.9717,
       "inr": 94552531096452.4,
       "jpy": 159662345910177.56,
       "krw": 1544215248885866,
       "kwd": 364434509432.1306,
       "lkr": 427920268418563.44,
       "mmk": 2214405433203098,
       "mxn": 24080889224864.2,
       "myr": 5295466242009.255,
       "ngn": 496488565538945.06,
       "nok": 11542718299960.855,
       "nzd": 1885576787088.8135,
       "php": 65806084286706.43,
       "pkr": 266256125798211.06,
       "pln": 5474510730836.499,
       "rub": 72904118684925.7,
       "sar": 4464125556291.431,
       "sek": 12053119045990.24,
       "sgd": 1635898760991.8171,
       "thb": 42225344602472.836,
       "try": 21321794515661.184,
       "twd": 35660416835706.06,
       "uah": 43837077601861.36,
       "vef": 118940115480.57123,
       "vnd": 27782878190610030,
       "zar": 19692648721377.734,
       "xdr": 871473620319.1072,
       "xag": 57986673871.205376,
       "xau": 665104858.2830482,
       "bits": 49144787785827.27,
       "sats": 4914478778582727
     },
     "total_volume": {
       "btc": 3199449.5244338815,
       "eth": 42942188.79889164,
       "ltc": 1212833937.6546621,
       "bch": 526419661.6324275,
       "bnb": 235518780.03159335,
       "eos": 60355055077.8607,
       "xrp": 201079445235.3555,
       "xlm": 580634356640.7572,
       "link": 8950700992.02343,
       "dot": 8313042794.845519,
       "yfi": 6497426.717044419,
       "usd": 77332480116.61362,
       "aed": 284046066092.327,
       "ars": 10328897240279.45,
       "aud": 110467901196.97987,
       "bdt": 7320543666401.577,
       "bhd": 29160995597.253304,
       "bmd": 77332480116.61362,
       "brl": 396452692565.83057,
       "cad": 99300472408.30013,
       "chf": 73644107477.45155,
       "clp": 70314557546030.69,
       "cny": 522558767891.9922,
       "czk": 1857216765148.1096,
       "dkk": 563691063408.738,
       "eur": 75759537471.04143,
       "gbp": 63729387534.180824,
       "hkd": 607051075680.2025,
       "huf": 29803156005568.87,
       "idr": 1146854042408617.5,
       "ils": 255920552403.83524,
       "inr": 6155608036582.187,
       "jpy": 10394421050682.262,
       "krw": 100532303958717.05,
       "kwd": 23725604899.777016,
       "lkr": 27858687787074.45,
       "mmk": 144163373764911.1,
       "mxn": 1567726569788.052,
       "myr": 344748196359.86316,
       "ngn": 32322656714341.09,
       "nok": 751460047735.4031,
       "nzd": 122755800290.06973,
       "php": 4284141911315.2993,
       "pkr": 17333944726247.518,
       "pln": 356404443755.36084,
       "rub": 4746241836922.206,
       "sar": 290625822830.5691,
       "sek": 784688422456.8695,
       "sgd": 106501131629.39848,
       "thb": 2748976336945.3184,
       "try": 1388102551597.1873,
       "twd": 2321582996417.311,
       "uah": 2853904216599.2236,
       "vef": 7743301234.076511,
       "vnd": 1808735380071911.5,
       "zar": 1282041055117.253,
       "xdr": 56735128702.51384,
       "xag": 3775078589.1934156,
       "xau": 43300002.26689435,
       "bits": 3199449524433.8813,
       "sats": 319944952443388.1
     },
     "market_cap_percentage": {
       "btc": 38.89727041514014,
       "eth": 18.201405103697642,
       "usdt": 5.5998467781630765,
       "usdc": 4.5687255440862025,
       "bnb": 4.514105248378146,
       "xrp": 1.563466365109607,
       "ada": 1.5467274655618157,
       "busd": 1.4981979136869568,
       "sol": 1.262950504901012,
       "dot": 0.8917193989887476
     },
     "market_cap_change_percentage_24h_usd": 3.8732397404155336,
     "updated_at": 1659968848
   }
 }
 */


import Foundation

struct GlobalData: Codable {
    let data: MarketDataModel?
}

struct MarketDataModel: Codable {
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double
    
    enum CodingKeys:String, CodingKey {
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
    }
    
    var marketCap: String {
        if let item = totalMarketCap.first(where: { $0.key == "usd" }) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    var volume: String {
        if let item = totalVolume.first(where: { $0.key == "usd" }) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    var btcDominance: String {
        if let item = marketCapPercentage.first(where: { $0.key == "btc" }) {
            return "\(item.value.asPercentString())"
        }
        return ""
    }
    
}

