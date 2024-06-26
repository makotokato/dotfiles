#!/bin/sh
mkdir -p /tmp/sym
(
  cd /tmp/sym
  adb pull /system/bin .
  adb pull /system/lib .
  adb pull /system/lib64 .
  adb pull /apex/com.android.art/lib64 .
  adb pull /apex/com.android.i18n/lib64 .
  mkdir sym
  cd sym
  /home/makoto/.mozbuild/dump_syms/dump_syms -t elf -s /tmp/sym/sym ../bin/app_process*
  # $HOME/.mozbuild/dump_syms/dump_syms -t elf ../bin/app_process*
  # $HOME/.mozbuild/dump_syms/dump_syms -t elf ../lib/*.so
  /home/makoto/.mozbuild/dump_syms/dump_syms -t elf -s /tmp/sym/sym ../lib64/*.so
  # $HOME/.mozbuild/dump_syms/dump_syms -t elf ../lib64/*.so
  find /tmp/sym/sym -name '*.sym' | sed 'p;s/.sym/.so.sym/' | xargs -n2 mv
  zip -r ../symbols.zip *
)
mv /tmp/sym/symbols.zip .
#rm -rf /tmp/sym
