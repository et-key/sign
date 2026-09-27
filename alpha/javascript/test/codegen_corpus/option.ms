`コーパスの身元（option_ms_schema.md）。codegen_sn.test.js が同じ字面を段1（lower.sn）と pass4 の両方へ渡す`
``
`以前は門の側が target・layer・charset を手で置いていた。Char の幅（ascii なら 1 byte）は charset が`
`決めるので、読むだけの器を足すと、その仮定が Sign の側にも要る。ファイルが宣言していない仮定を`
`二か所に置かないよう、ここに書く`

target  : aarch64_qemu
layer   : 1
charset : ascii
