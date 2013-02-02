require 'thor'

module Terebi

  class CLI < Thor

    desc "import", "tells iFlicks to import a video via applescript"
    #method_option :file, :desc => "this is the file you have to pass in"
    def import(path)
      # path is file or folder
    #     - terebi iflicks import "/whatever/tv/show/s01e02.avi"
    end

    desc "update-episode-art", "updates artwork for a file"
    def update_episode_art(file)
    end

    desc "update-show-art", "updates artwork for a show"
    def update_artwork(folder)
    end

    desc "delete-show", "deletes show"
    def delete_show(folder)
    end

    desc "delete-episode", "delete an episode"
    def delete_episode(file)
    end

    desc "delete-movie", "delete a movie"
    def delete_movie(folder)
    end

    desc "clean-library", "does fancy stuff to cleanup the library"
    def clean_library(who_knows)
    end


    # - terebi library add "/some/tv/show"
    # - terebi library delete [episode|show|movie]



  end

end


#!/Users/bill/.rbenv/versions/1.9.3-p327/bin/ruby


# TVShowLibrary.update_show("Summer Heights High")
