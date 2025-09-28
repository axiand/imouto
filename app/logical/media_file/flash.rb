# frozen_string_literal: true

class MediaFile::Flash < MediaFile
  # XXX Some Flash files have fractional dimensions; round up to nearest integer.
  # XXX Some Flash files have negative dimensions; clamp to positive numbers.
  def dimensions
    [metadata.width.ceil.clamp(1..), metadata.height.ceil.clamp(1..)]
  end

  def preview!(max_width, max_height, **options)
    nil
  end

  def ai_tags(autotagger: AutotaggerClient.new)
    []
  end
end
