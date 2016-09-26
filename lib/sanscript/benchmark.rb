# frozen_string_literal: true

# :nocov:
begin
  require "benchmark/ips"
rescue LoadError
  module Benchmark
    def self.ips(*)
      raise NotImplementedError, "You must install the `benchmark-ips` gem first."
    end
  end
end
# :nocov:

module Sanscript
  # Benchmark/testing module.
  module Benchmark
    module_function

    # Runs benchmark-ips test on detection methods.
    def detect!(time = 2, warmup = 1)
      deva_string = "नानाशास्त्रसुभाषितामृतरसैः श्रोत्रोत्सवं कुर्वतां येषां यान्ति दिनानि पण्डितजनव्यायामखिन्नात्मनाम् तेषां जन्म च जीवितं च सुकृतं तैर् एव भूर् भूषिता शेषैह् किं पशुवद् विवेकरहितैर् भूभारभूतैर् नरः"
      malayalam_string = "നാനാശാസ്ത്രസുഭാഷിതാമൃതരസൈഃ ശ്രോത്രോത്സവം കുര്വതാം യേഷാം യാന്തി ദിനാനി പണ്ഡിതജനവ്യായാമഖിന്നാത്മനാമ് തേഷാം ജന്മ ച ജീവിതം ച സുകൃതം തൈര് ഏവ ഭൂര് ഭൂഷിതാ ശേഷൈഹ് കിം പശുവദ് വിവേകരഹിതൈര് ഭൂഭാരഭൂതൈര് നരഃ"
      iast_string = "nānāśāstrasubhāṣitāmṛtarasaiḥ śrotrotsavaṃ kurvatāṃ yeṣāṃ yānti dināni paṇḍitajanavyāyāmakhinnātmanām teṣāṃ janma ca jīvitaṃ ca sukṛtaṃ tair eva bhūr bhūṣitā śeṣaih kiṃ paśuvad vivekarahitair bhūbhārabhūtair naraḥ"
      slp1_string = "nAnASAstrasuBAzitAmftarasEH SrotrotsavaM kurvatAM yezAM yAnti dinAni paRqitajanavyAyAmaKinnAtmanAm tezAM janma ca jIvitaM ca sukftaM tEr eva BUr BUzitA SezEh kiM paSuvad vivekarahitEr BUBAraBUtEr naraH"
      hk_string = "nAnAzAstrasubhASitAmRtarasaiH zrotrotsavaM kurvatAM yeSAM yAnti dinAni paNDitajanavyAyAmakhinnAtmanAm teSAM janma ca jIvitaM ca sukRtaM tair eva bhUr bhUSitA zeSaih kiM pazuvad vivekarahitair bhUbhArabhUtair naraH"

      ::Benchmark.ips do |x|
        x.config(time: time, warmup: warmup)
        x.report("Detect Devanagari") do
          Sanscript::Detect.detect_scheme(deva_string)
        end
        x.report("Detect Malayalam") do
          Sanscript::Detect.detect_scheme(malayalam_string)
        end
        x.report("Detect IAST") do
          Sanscript::Detect.detect_scheme(iast_string)
        end
        x.report("Detect SLP1") do
          Sanscript::Detect.detect_scheme(slp1_string)
        end
        x.report("Detect HK") do
          Sanscript::Detect.detect_scheme(hk_string)
        end
        x.compare!
      end
      true
    end

    # Runs benchmark-ips test on roman-source transliteration methods.
    def transliterate_roman!(time = 2, warmup = 1)
      iast_string = "nānāśāstrasubhāṣitāmṛtarasaiḥ śrotrotsavaṃ kurvatāṃ yeṣāṃ yānti dināni paṇḍitajanavyāyāmakhinnātmanām teṣāṃ janma ca jīvitaṃ ca sukṛtaṃ tair eva bhūr bhūṣitā śeṣaih kiṃ paśuvad vivekarahitair bhūbhārabhūtair naraḥ"
      slp1_string = "nAnASAstrasuBAzitAmftarasEH SrotrotsavaM kurvatAM yezAM yAnti dinAni paRqitajanavyAyAmaKinnAtmanAm tezAM janma ca jIvitaM ca sukftaM tEr eva BUr BUzitA SezEh kiM paSuvad vivekarahitEr BUBAraBUtEr naraH"
      hk_string = "nAnAzAstrasubhASitAmRtarasaiH zrotrotsavaM kurvatAM yeSAM yAnti dinAni paNDitajanavyAyAmakhinnAtmanAm teSAM janma ca jIvitaM ca sukRtaM tair eva bhUr bhUSitA zeSaih kiM pazuvad vivekarahitair bhUbhArabhUtair naraH"

      ::Benchmark.ips do |x|
        x.config(time: time, warmup: warmup)

        x.report("IAST==>Devanagari") do
          Sanscript.transliterate(iast_string, :iast, :devanagari)
        end
        x.report("IAST==>SLP1") do
          Sanscript.transliterate(iast_string, :iast, :slp1)
        end
        x.report("IAST==>SLP1") do
          Sanscript.transliterate(iast_string, :iast, :hk)
        end
        x.report("SLP1==>Devanagari") do
          Sanscript.transliterate(slp1_string, :slp1, :devanagari)
        end
        x.report("SLP1==>IAST") do
          Sanscript.transliterate(slp1_string, :slp1, :iast)
        end
        x.report("SLP1==>HK") do
          Sanscript.transliterate(slp1_string, :slp1, :hk)
        end
        x.report("HK==>Devanagari") do
          Sanscript.transliterate(hk_string, :hk, :devanagari)
        end
        x.report("HK==>IAST") do
          Sanscript.transliterate(hk_string, :hk, :iast)
        end
        x.report("HK==>SLP1") do
          Sanscript.transliterate(hk_string, :hk, :slp1)
        end
        x.compare!
      end
      true
    end

    # Runs benchmark-ips test on brahmic-source transliteration methods.
    def transliterate_brahmic!(time = 2, warmup = 1)
      deva_string = "नानाशास्त्रसुभाषितामृतरसैः श्रोत्रोत्सवं कुर्वतां येषां यान्ति दिनानि पण्डितजनव्यायामखिन्नात्मनाम् तेषां जन्म च जीवितं च सुकृतं तैर् एव भूर् भूषिता शेषैह् किं पशुवद् विवेकरहितैर् भूभारभूतैर् नरः"

      ::Benchmark.ips do |x|
        x.config(time: time, warmup: warmup)
        x.report("Devanagari==>IAST") do
          Sanscript.transliterate(deva_string, :devanagari, :iast)
        end
        x.report("Devanagari==>SLP1") do
          Sanscript.transliterate(deva_string, :devanagari, :slp1)
        end
        x.report("Devanagari==>HK") do
          Sanscript.transliterate(deva_string, :devanagari, :hk)
        end
        x.compare!
      end
      true
    end
  end
end
