# frozen_string_literal: true

require "sanscript/refinements"
begin
  require "benchmark/ips"
rescue LoadError
  module Benchmark
    def self.ips(*)
      raise NotImplementedError, "You must install the `benchmark-ips` gem first."
    end
  end
end

module Sanscript
  using Refinements
  module Benchmark
    module_function

    def detect!
      iast_string = "nānāśāstrasubhāṣitāmṛtarasaiḥ śrotrotsavaṃ kurvatāṃ yeṣāṃ yānti dināni paṇḍitajanavyāyāmakhinnātmanām teṣāṃ janma ca jīvitaṃ ca sukṛtaṃ tair eva bhūr bhūṣitā śeṣaih kiṃ paśuvad vivekarahitair bhūbhārabhūtair naraḥ"
      deva_string = "नानाशास्त्रसुभाषितामृतरसैः श्रोत्रोत्सवं कुर्वतां येषां यान्ति दिनानि पण्डितजनव्यायामखिन्नात्मनाम् तेषां जन्म च जीवितं च सुकृतं तैर् एव भूर् भूषिता शेषैह् किं पशुवद् विवेकरहितैर् भूभारभूतैर् नरः"
      slp1_string = "nAnASAstrasuBAzitAmftarasEH SrotrotsavaM kurvatAM yezAM yAnti dinAni paRqitajanavyAyAmaKinnAtmanAm tezAM janma ca jIvitaM ca sukftaM tEr eva BUr BUzitA SezEh kiM paSuvad vivekarahitEr BUBAraBUtEr naraH"
      hk_string = "nAnAzAstrasubhASitAmRtarasaiH zrotrotsavaM kurvatAM yeSAM yAnti dinAni paNDitajanavyAyAmakhinnAtmanAm teSAM janma ca jIvitaM ca sukRtaM tair eva bhUr bhUSitA zeSaih kiM pazuvad vivekarahitair bhUbhArabhUtair naraH"
      malayalam_string = "അ ആ ഇ ഈ ഉ ഊ ഋ ൠ ഌ ൡ എ ഏ ഐ ഒ ഓ ഔ"

      ::Benchmark.ips do |x|
        x.config(time: 5, warmup: 1)
        x.report("Detect Devanagari") do
          Sanscript::Detect.detect_script(deva_string) == :devanagari
        end
        x.report("Detect Malayalam") do
          Sanscript::Detect.detect_script(malayalam_string) == :malayalam
        end
        x.report("Detect IAST") do
          Sanscript::Detect.detect_script(iast_string) == :iast
        end
        x.report("Detect SLP1") do
          Sanscript::Detect.detect_script(slp1_string) == :slp1
        end
        x.report("Detect HK") do
          Sanscript::Detect.detect_script(hk_string) == :hk
        end
        x.compare!
      end
      true
    end

    def transliterate!
      iast_string = "nānāśāstrasubhāṣitāmṛtarasaiḥ śrotrotsavaṃ kurvatāṃ yeṣāṃ yānti dināni paṇḍitajanavyāyāmakhinnātmanām teṣāṃ janma ca jīvitaṃ ca sukṛtaṃ tair eva bhūr bhūṣitā śeṣaih kiṃ paśuvad vivekarahitair bhūbhārabhūtair naraḥ"
      deva_string = "नानाशास्त्रसुभाषितामृतरसैः श्रोत्रोत्सवं कुर्वतां येषां यान्ति दिनानि पण्डितजनव्यायामखिन्नात्मनाम् तेषां जन्म च जीवितं च सुकृतं तैर् एव भूर् भूषिता शेषैह् किं पशुवद् विवेकरहितैर् भूभारभूतैर् नरः"
      slp1_string = "nAnASAstrasuBAzitAmftarasEH SrotrotsavaM kurvatAM yezAM yAnti dinAni paRqitajanavyAyAmaKinnAtmanAm tezAM janma ca jIvitaM ca sukftaM tEr eva BUr BUzitA SezEh kiM paSuvad vivekarahitEr BUBAraBUtEr naraH"

      ::Benchmark.ips do |x|
        x.config(time: 5, warmup: 2)

        x.report("IAST==>Devanagari") do
          Sanscript.transliterate(iast_string, :iast, :devanagari) == deva_string
        end
        x.report("IAST==>SLP1") do
          Sanscript.transliterate(iast_string, :iast, :slp1) == slp1_string
        end
        x.report("SLP1==>Devanagari") do
          Sanscript.transliterate(slp1_string, :slp1, :devanagari) == deva_string
        end
        x.report("SLP1==>IAST") do
          Sanscript.transliterate(slp1_string, :slp1, :iast) == iast_string
        end
        x.report("Devanagari==>SLP1") do
          Sanscript.transliterate(deva_string, :devanagari, :slp1) == slp1_string
        end
        x.report("Devanagari==>IAST") do
          Sanscript.transliterate(deva_string, :devanagari, :iast) == iast_string
        end
        x.compare!
      end
      true
    end
  end
end
