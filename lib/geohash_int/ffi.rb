require "ffi"

module GeohashInt
  # :stopdoc:
  module FFI
    extend ::FFI::Library
    ffi_lib File.expand_path("../../../ext/geohash_int/geohash.#{::FFI::Platform::LIBSUFFIX}", __FILE__)

    class Bits < ::FFI::Struct
      layout :bits, :uint64,
             :step, :uint8
    end

    class Range < ::FFI::Struct
      layout :max, :double,
             :min, :double
    end

    class Area < ::FFI::Struct
      layout :hash,      Bits,
             :latitude,  Range,
             :longitude, Range
    end

    class Neighbors < ::FFI::Struct
      layout :north,      Bits,
             :east,       Bits,
             :west,       Bits,
             :south,      Bits,
             :north_east, Bits,
             :south_east, Bits,
             :north_west, Bits,
             :south_west, Bits
    end

    attach_function :geohash_encode, [Range.val, Range.val, :double, :double, :uint8, :pointer], :int
    attach_function :geohash_decode, [Range.val, Range.val, Bits.val, :pointer], :int

    attach_function :geohash_get_neighbors, [Bits.val, :pointer], :int
    attach_function :geohash_get_neighbor, [Bits.val, :int, :pointer], :int
  end
end