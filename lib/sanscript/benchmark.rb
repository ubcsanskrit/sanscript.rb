# frozen_string_literal: true

require "sanscript/refinements"
require "benchmark"

module Sanscript
  using Refinements
  module Benchmark
    module_function

    def detection!
      n = 100_000
      iast_string = "nānāśāstrasubhāṣitāmṛtarasaiḥ śrotrotsavaṃ kurvatāṃ yeṣāṃ yānti dināni paṇḍitajanavyāyāmakhinnātmanām teṣāṃ janma ca jīvitaṃ ca sukṛtaṃ tair eva bhūr bhūṣitā śeṣaih kiṃ paśuvad vivekarahitair bhūbhārabhūtair naraḥ"
      deva_string = "नानाशास्त्रसुभाषितामृतरसैः श्रोत्रोत्सवं कुर्वतां येषां यान्ति दिनानि पण्डितजनव्यायामखिन्नात्मनाम् तेषां जन्म च जीवितं च सुकृतं तैर् एव भूर् भूषिता शेषैह् किं पशुवद् विवेकरहितैर् भूभारभूतैर् नरः"

      ::Benchmark.bmbm(18) do |x|
        x.report("Detect IAST") do
          n.times { raise unless Sanscript.detect(iast_string) == :iast }
        end
        x.report("Detect Devanagari") do
          n.times { raise unless Sanscript.detect(deva_string) == :devanagari }
        end
      end
    end

    def transliteration!
      n = 5_000
      iast_string = "nānāśāstrasubhāṣitāmṛtarasaiḥ śrotrotsavaṃ kurvatāṃ yeṣāṃ yānti dināni paṇḍitajanavyāyāmakhinnātmanām teṣāṃ janma ca jīvitaṃ ca sukṛtaṃ tair eva bhūr bhūṣitā śeṣaih kiṃ paśuvad vivekarahitair bhūbhārabhūtair naraḥ"

      deva_string = "नानाशास्त्रसुभाषितामृतरसैः श्रोत्रोत्सवं कुर्वतां येषां यान्ति दिनानि पण्डितजनव्यायामखिन्नात्मनाम् तेषां जन्म च जीवितं च सुकृतं तैर् एव भूर् भूषिता शेषैह् किं पशुवद् विवेकरहितैर् भूभारभूतैर् नरः"
      ::Benchmark.bmbm(18) do |x|
        x.report("IAST**>Devanagari") do
          n.times { Sanscript.transliterate(iast_string, :devanagari) }
        end
        x.report("IAST==>Devanagari") do
          n.times { Sanscript.transliterate(iast_string, :iast, :devanagari) }
        end
        x.report("IAST**>SLP1") do
          n.times { Sanscript.transliterate(iast_string, :slp1) }
        end
        x.report("IAST==>SLP1") do
          n.times { Sanscript.transliterate(iast_string, :iast, :slp1) }
        end
        x.report("Devanagari**>SLP1") do
          n.times { Sanscript.transliterate(deva_string, :slp1) }
        end
        x.report("Devanagari**>IAST") do
          n.times { Sanscript.transliterate(deva_string, :iast) }
        end
      end
    end
  end
end
