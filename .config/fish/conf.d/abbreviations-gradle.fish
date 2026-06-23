if status --is-interactive
    function __gradle_abbr
        if test -f ./gradlew
            echo ./gradlew
        else
            echo gradle
        end
    end
    abbr --add gw --function __gradle_abbr

    function __gradle_test_abbr
        set -l gradle_cmd (__gradle_abbr)

        set -l test_files (rg --type java --glob '**/src/test/**' --files-with-matches @Test)
        if test -z "$test_files"
            echo "No tests found"
            return
        end

        set -l selected_file (printf "%s\n" $test_files | zf)

        if test -n "$selected_file"
            set -l test_class (basename "$selected_file" .java)

            # Find the submodule directory (nearest parent with gradlew or build.gradle)
            set -l current_dir (dirname "$selected_file")
            while test "$current_dir" != .
                if test -f "$current_dir/gradlew" || test -f "$current_dir/build.gradle" || test -f "$current_dir/build.gradle.kts"
                    break
                end
                set current_dir (dirname "$current_dir")
            end

            if test "$current_dir" != "."
                set -l p_flag ""
                if test "$current_dir" != (pwd)
                    set p_flag "-p $(basename $current_dir)"
                end
                echo "$gradle_cmd $p_flag test --tests \"$test_class\" --rerun"
            else
                echo "$gradle_cmd test --tests \"$test_class\" --rerun"
            end
        end
    end
    abbr --add gwt --function __gradle_test_abbr
end
