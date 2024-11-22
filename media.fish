function media
    set image_extensions "jpg" "jpeg" "png" "gif" "bmp" "tiff"
    set audio_extensions "mp3" "wav" "flac" "aac" "ogg"
    set video_extensions "mp4" "mkv" "avi" "mov" "wmv"

    set image_count 0
    set audio_count 0
    set video_count 0
    set total_audio_duration 0
    set total_video_duration 0

    # Loop through files in the current directory and subdirectories
    for file in (find . -type f)
        set ext (echo (string split -r . $file)[-1] | tr '[:upper:]' '[:lower:]')

        # Check for image files
        if contains -- $ext $image_extensions
            set image_count (math $image_count + 1)
        end

        # Check for audio files
        if contains -- $ext $audio_extensions
            set audio_count (math $audio_count + 1)
            set duration (ffprobe -i $file -show_entries format=duration -v quiet -of csv="p=0" 2>/dev/null)

            # Validate and add to total_audio_duration
            if test -n "$duration" -a "$duration" != "N/A"
                set total_audio_duration (math $total_audio_duration + $duration)
            end
        end

        # Check for video files
        if contains -- $ext $video_extensions
            set video_count (math $video_count + 1)
            set duration (ffprobe -i $file -show_entries format=duration -v quiet -of csv="p=0" 2>/dev/null)

            # Validate and add to total_video_duration
            if test -n "$duration" -a "$duration" != "N/A"
                set total_video_duration (math $total_video_duration + $duration)
            end
        end
    end

    # Display the results
    echo "Media Summary:"
    echo "  Images: $image_count"
    echo "  Audio files: $audio_count (Total duration: "(math $total_audio_duration / 60)" minutes)"
    echo "  Video files: $video_count (Total duration: "(math $total_video_duration / 60)" minutes)"
end
