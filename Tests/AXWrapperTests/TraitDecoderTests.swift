import Testing
@testable import AXWrapper

@Suite("TraitDecoder Tests")
struct TraitDecoderTests {

    // MARK: - Individual Trait Tests (Bit Positions 0-17)

    @Test("Decodes button trait at bit position 0")
    func decodesButtonTrait() {
        let bitmask: UInt64 = 1 << 0
        let traits = TraitDecoder.decode(bitmask)
        #expect(traits == ["button"])
    }

    @Test("Decodes link trait at bit position 1")
    func decodesLinkTrait() {
        let bitmask: UInt64 = 1 << 1
        let traits = TraitDecoder.decode(bitmask)
        #expect(traits == ["link"])
    }

    @Test("Decodes image trait at bit position 2")
    func decodesImageTrait() {
        let bitmask: UInt64 = 1 << 2
        let traits = TraitDecoder.decode(bitmask)
        #expect(traits == ["image"])
    }

    @Test("Decodes selected trait at bit position 3")
    func decodesSelectedTrait() {
        let bitmask: UInt64 = 1 << 3
        let traits = TraitDecoder.decode(bitmask)
        #expect(traits == ["selected"])
    }

    @Test("Decodes playsSound trait at bit position 4")
    func decodesPlaysSoundTrait() {
        let bitmask: UInt64 = 1 << 4
        let traits = TraitDecoder.decode(bitmask)
        #expect(traits == ["playsSound"])
    }

    @Test("Decodes keyboardKey trait at bit position 5")
    func decodesKeyboardKeyTrait() {
        let bitmask: UInt64 = 1 << 5
        let traits = TraitDecoder.decode(bitmask)
        #expect(traits == ["keyboardKey"])
    }

    @Test("Decodes staticText trait at bit position 6")
    func decodesStaticTextTrait() {
        let bitmask: UInt64 = 1 << 6
        let traits = TraitDecoder.decode(bitmask)
        #expect(traits == ["staticText"])
    }

    @Test("Decodes summaryElement trait at bit position 7")
    func decodesSummaryElementTrait() {
        let bitmask: UInt64 = 1 << 7
        let traits = TraitDecoder.decode(bitmask)
        #expect(traits == ["summaryElement"])
    }

    @Test("Decodes notEnabled trait at bit position 8")
    func decodesNotEnabledTrait() {
        let bitmask: UInt64 = 1 << 8
        let traits = TraitDecoder.decode(bitmask)
        #expect(traits == ["notEnabled"])
    }

    @Test("Decodes updatesFrequently trait at bit position 9")
    func decodesUpdatesFrequentlyTrait() {
        let bitmask: UInt64 = 1 << 9
        let traits = TraitDecoder.decode(bitmask)
        #expect(traits == ["updatesFrequently"])
    }

    @Test("Decodes searchField trait at bit position 10")
    func decodesSearchFieldTrait() {
        let bitmask: UInt64 = 1 << 10
        let traits = TraitDecoder.decode(bitmask)
        #expect(traits == ["searchField"])
    }

    @Test("Decodes startsMediaSession trait at bit position 11")
    func decodesStartsMediaSessionTrait() {
        let bitmask: UInt64 = 1 << 11
        let traits = TraitDecoder.decode(bitmask)
        #expect(traits == ["startsMediaSession"])
    }

    @Test("Decodes adjustable trait at bit position 12")
    func decodesAdjustableTrait() {
        let bitmask: UInt64 = 1 << 12
        let traits = TraitDecoder.decode(bitmask)
        #expect(traits == ["adjustable"])
    }

    @Test("Decodes allowsDirectInteraction trait at bit position 13")
    func decodesAllowsDirectInteractionTrait() {
        let bitmask: UInt64 = 1 << 13
        let traits = TraitDecoder.decode(bitmask)
        #expect(traits == ["allowsDirectInteraction"])
    }

    @Test("Decodes causesPageTurn trait at bit position 14")
    func decodesCausesPageTurnTrait() {
        let bitmask: UInt64 = 1 << 14
        let traits = TraitDecoder.decode(bitmask)
        #expect(traits == ["causesPageTurn"])
    }

    @Test("Decodes tabBar trait at bit position 15")
    func decodesTabBarTrait() {
        let bitmask: UInt64 = 1 << 15
        let traits = TraitDecoder.decode(bitmask)
        #expect(traits == ["tabBar"])
    }

    @Test("Decodes header trait at bit position 16")
    func decodesHeaderTrait() {
        let bitmask: UInt64 = 1 << 16
        let traits = TraitDecoder.decode(bitmask)
        #expect(traits == ["header"])
    }

    @Test("Decodes toggle trait at bit position 17")
    func decodesToggleTrait() {
        let bitmask: UInt64 = 1 << 17
        let traits = TraitDecoder.decode(bitmask)
        #expect(traits == ["toggle"])
    }

    // MARK: - Combined Traits Tests

    @Test("Decodes button and selected traits combined")
    func decodesButtonAndSelectedTraits() {
        let bitmask: UInt64 = (1 << 0) | (1 << 3)
        let traits = TraitDecoder.decode(bitmask)
        #expect(traits == ["button", "selected"])
    }

    @Test("Decodes button, link, and image traits combined")
    func decodesMultipleTraits() {
        let bitmask: UInt64 = (1 << 0) | (1 << 1) | (1 << 2)
        let traits = TraitDecoder.decode(bitmask)
        #expect(traits == ["button", "link", "image"])
    }

    @Test("Decodes staticText and notEnabled traits combined")
    func decodesStaticTextAndNotEnabled() {
        let bitmask: UInt64 = (1 << 6) | (1 << 8)
        let traits = TraitDecoder.decode(bitmask)
        #expect(traits == ["staticText", "notEnabled"])
    }

    @Test("Decodes searchField and adjustable traits combined")
    func decodesSearchFieldAndAdjustable() {
        let bitmask: UInt64 = (1 << 10) | (1 << 12)
        let traits = TraitDecoder.decode(bitmask)
        #expect(traits == ["searchField", "adjustable"])
    }

    @Test("Decodes header and toggle traits combined")
    func decodesHeaderAndToggle() {
        let bitmask: UInt64 = (1 << 16) | (1 << 17)
        let traits = TraitDecoder.decode(bitmask)
        #expect(traits == ["header", "toggle"])
    }

    @Test("Decodes multiple non-adjacent traits")
    func decodesNonAdjacentTraits() {
        let bitmask: UInt64 = (1 << 0) | (1 << 5) | (1 << 10) | (1 << 15)
        let traits = TraitDecoder.decode(bitmask)
        #expect(traits == ["button", "keyboardKey", "searchField", "tabBar"])
    }

    @Test("Decodes complex combination with six traits")
    func decodesComplexCombination() {
        let bitmask: UInt64 = (1 << 0) | (1 << 3) | (1 << 6) | (1 << 8) | (1 << 12) | (1 << 16)
        let traits = TraitDecoder.decode(bitmask)
        #expect(traits == ["button", "selected", "staticText", "notEnabled", "adjustable", "header"])
    }

    @Test("Decodes all traits combined")
    func decodesAllTraits() {
        var bitmask: UInt64 = 0
        for bit in 0...17 {
            bitmask |= (1 << bit)
        }
        let traits = TraitDecoder.decode(bitmask)
        #expect(traits.count == 18)
        #expect(traits == [
            "button", "link", "image", "selected", "playsSound", "keyboardKey",
            "staticText", "summaryElement", "notEnabled", "updatesFrequently",
            "searchField", "startsMediaSession", "adjustable", "allowsDirectInteraction",
            "causesPageTurn", "tabBar", "header", "toggle"
        ])
    }

    // MARK: - Empty Bitmask Tests

    @Test("Decodes empty bitmask as empty array")
    func decodesEmptyBitmask() {
        let bitmask: UInt64 = 0
        let traits = TraitDecoder.decode(bitmask)
        #expect(traits.isEmpty)
    }

    @Test("Decodes zero explicitly returns empty array")
    func decodesZeroExplicitly() {
        let traits = TraitDecoder.decode(0)
        #expect(traits == [])
    }

    // MARK: - Edge Cases Tests

    @Test("Decodes bitmask with unknown bit 18 ignores unknown bit")
    func decodesUnknownBit18() {
        let bitmask: UInt64 = (1 << 18)
        let traits = TraitDecoder.decode(bitmask)
        #expect(traits.isEmpty)
    }

    @Test("Decodes bitmask with unknown bit 20 ignores unknown bit")
    func decodesUnknownBit20() {
        let bitmask: UInt64 = (1 << 20)
        let traits = TraitDecoder.decode(bitmask)
        #expect(traits.isEmpty)
    }

    @Test("Decodes bitmask with known and unknown bits mixed")
    func decodesKnownAndUnknownBitsMixed() {
        let bitmask: UInt64 = (1 << 0) | (1 << 18) | (1 << 3) | (1 << 25)
        let traits = TraitDecoder.decode(bitmask)
        #expect(traits == ["button", "selected"])
    }

    @Test("Decodes high bit position 30 ignores unknown bit")
    func decodesHighBitPosition() {
        let bitmask: UInt64 = (1 << 30)
        let traits = TraitDecoder.decode(bitmask)
        #expect(traits.isEmpty)
    }

    @Test("Decodes very high bit position 50 ignores unknown bit")
    func decodesVeryHighBitPosition() {
        let bitmask: UInt64 = (1 << 50)
        let traits = TraitDecoder.decode(bitmask)
        #expect(traits.isEmpty)
    }

    @Test("Decodes maximum bit position 63 ignores unknown bit")
    func decodesMaximumBitPosition() {
        let bitmask: UInt64 = (1 << 63)
        let traits = TraitDecoder.decode(bitmask)
        #expect(traits.isEmpty)
    }

    @Test("Decodes maximum UInt64 value filters only known traits")
    func decodesMaximumUInt64() {
        let bitmask: UInt64 = UInt64.max
        let traits = TraitDecoder.decode(bitmask)
        #expect(traits.count == 18)
        #expect(traits.contains("button"))
        #expect(traits.contains("link"))
        #expect(traits.contains("toggle"))
    }

    @Test("Decodes alternating bits pattern")
    func decodesAlternatingBits() {
        // Alternating bits: 0, 2, 4, 6, 8, 10, 12, 14, 16
        let bitmask: UInt64 = 0b101010101010101010101
        let traits = TraitDecoder.decode(bitmask)
        #expect(traits == [
            "button", "image", "playsSound", "staticText",
            "notEnabled", "searchField", "adjustable", "causesPageTurn", "header"
        ])
    }

    @Test("Decodes first and last trait bits only")
    func decodesFirstAndLastTraitBits() {
        let bitmask: UInt64 = (1 << 0) | (1 << 17)
        let traits = TraitDecoder.decode(bitmask)
        #expect(traits == ["button", "toggle"])
    }

    // MARK: - Boundary Tests

    @Test("Decodes bitmask with bits 0 through 8 set")
    func decodesFirstNineBits() {
        let bitmask: UInt64 = 0b111111111
        let traits = TraitDecoder.decode(bitmask)
        #expect(traits.count == 9)
        #expect(traits == [
            "button", "link", "image", "selected", "playsSound",
            "keyboardKey", "staticText", "summaryElement", "notEnabled"
        ])
    }

    @Test("Decodes bitmask with bits 9 through 17 set")
    func decodesLastNineBits() {
        let bitmask: UInt64 = 0b111111111000000000
        let traits = TraitDecoder.decode(bitmask)
        #expect(traits.count == 9)
        #expect(traits == [
            "updatesFrequently", "searchField", "startsMediaSession",
            "adjustable", "allowsDirectInteraction", "causesPageTurn",
            "tabBar", "header", "toggle"
        ])
    }

    @Test("Decodes literal value 1")
    func decodesLiteralOne() {
        let traits = TraitDecoder.decode(1)
        #expect(traits == ["button"])
    }

    @Test("Decodes literal value 2")
    func decodesLiteralTwo() {
        let traits = TraitDecoder.decode(2)
        #expect(traits == ["link"])
    }

    @Test("Decodes literal value 3")
    func decodesLiteralThree() {
        let traits = TraitDecoder.decode(3)
        #expect(traits == ["button", "link"])
    }

    @Test("Decodes common button selected pattern")
    func decodesCommonButtonSelectedPattern() {
        let traits = TraitDecoder.decode(9) // 1 << 0 | 1 << 3
        #expect(traits == ["button", "selected"])
    }
}
