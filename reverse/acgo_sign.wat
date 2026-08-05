(module
  (type (;0;) (func (param i32) (result i32)))
  (type (;1;) (func (param i32 i32 i32) (result i32)))
  (type (;2;) (func (param i32 i32 i32)))
  (type (;3;) (func (param i32 i32)))
  (type (;4;) (func (result i32)))
  (type (;5;) (func (param i32 i32) (result i32)))
  (type (;6;) (func (param i32 i32 i32 i32 i32)))
  (type (;7;) (func (param i32 i32 i32 i32) (result i32)))
  (type (;8;) (func (param i32 f64 i32 i32 i32 i32) (result i32)))
  (type (;9;) (func))
  (type (;10;) (func (param i32)))
  (import "a" "a" (func (;0;) (type 4)))
  (import "a" "b" (func (;1;) (type 0)))
  (func (;2;) (type 0) (param i32) (result i32)
    (local i32 i32)
    i32.const 2228
    i32.load
    local.tee 1
    local.get 0
    i32.const 3
    i32.add
    i32.const -4
    i32.and
    local.tee 2
    i32.add
    local.set 0
    block  ;; label = @1
      local.get 2
      i32.const 0
      local.get 0
      local.get 1
      i32.le_u
      select
      br_if 0 (;@1;)
      local.get 0
      memory.size
      i32.const 16
      i32.shl
      i32.gt_u
      if  ;; label = @2
        local.get 0
        call 1
        i32.eqz
        br_if 1 (;@1;)
      end
      i32.const 2228
      local.get 0
      i32.store
      local.get 1
      return
    end
    i32.const 2564
    i32.const 48
    i32.store
    i32.const -1)
  (func (;3;) (type 6) (param i32 i32 i32 i32 i32)
    (local i32)
    global.get 0
    i32.const 256
    i32.sub
    local.tee 5
    global.set 0
    local.get 4
    i32.const 73728
    i32.and
    local.get 2
    local.get 3
    i32.le_s
    i32.or
    i32.eqz
    if  ;; label = @1
      local.get 5
      local.get 1
      i32.const 255
      i32.and
      local.get 2
      local.get 3
      i32.sub
      local.tee 2
      i32.const 256
      local.get 2
      i32.const 256
      i32.lt_u
      local.tee 1
      select
      call 6
      drop
      local.get 1
      i32.eqz
      if  ;; label = @2
        loop  ;; label = @3
          local.get 0
          local.get 5
          i32.const 256
          call 4
          local.get 2
          i32.const 256
          i32.sub
          local.tee 2
          i32.const 255
          i32.gt_u
          br_if 0 (;@3;)
        end
      end
      local.get 0
      local.get 5
      local.get 2
      call 4
    end
    local.get 5
    i32.const 256
    i32.add
    global.set 0)
  (func (;4;) (type 2) (param i32 i32 i32)
    (local i32 i32 i32)
    local.get 0
    i32.load8_u
    i32.const 32
    i32.and
    i32.eqz
    if  ;; label = @1
      block  ;; label = @2
        local.get 1
        local.set 3
        block  ;; label = @3
          local.get 2
          local.get 0
          local.tee 1
          i32.load offset=16
          local.tee 0
          if (result i32)  ;; label = @4
            local.get 0
          else
            block (result i32)  ;; label = @5
              local.get 1
              local.get 1
              i32.load8_u offset=74
              local.tee 0
              i32.const 1
              i32.sub
              local.get 0
              i32.or
              i32.store8 offset=74
              local.get 1
              i32.load
              local.tee 0
              i32.const 8
              i32.and
              if  ;; label = @6
                local.get 1
                local.get 0
                i32.const 32
                i32.or
                i32.store
                i32.const -1
                br 1 (;@5;)
              end
              local.get 1
              i64.const 0
              i64.store offset=4 align=4
              local.get 1
              local.get 1
              i32.load offset=44
              local.tee 0
              i32.store offset=28
              local.get 1
              local.get 0
              i32.store offset=20
              local.get 1
              local.get 0
              local.get 1
              i32.load offset=48
              i32.add
              i32.store offset=16
              i32.const 0
            end
            br_if 1 (;@3;)
            local.get 1
            i32.load offset=16
          end
          local.get 1
          i32.load offset=20
          local.tee 5
          i32.sub
          i32.gt_u
          if  ;; label = @4
            local.get 1
            local.get 3
            local.get 2
            local.get 1
            i32.load offset=36
            call_indirect (type 1)
            drop
            br 2 (;@2;)
          end
          block  ;; label = @4
            local.get 1
            i32.load8_s offset=75
            i32.const 0
            i32.lt_s
            br_if 0 (;@4;)
            local.get 2
            local.set 0
            loop  ;; label = @5
              local.get 0
              local.tee 4
              i32.eqz
              br_if 1 (;@4;)
              local.get 3
              local.get 4
              i32.const 1
              i32.sub
              local.tee 0
              i32.add
              i32.load8_u
              i32.const 10
              i32.ne
              br_if 0 (;@5;)
            end
            local.get 1
            local.get 3
            local.get 4
            local.get 1
            i32.load offset=36
            call_indirect (type 1)
            local.get 4
            i32.lt_u
            br_if 1 (;@3;)
            local.get 3
            local.get 4
            i32.add
            local.set 3
            local.get 2
            local.get 4
            i32.sub
            local.set 2
            local.get 1
            i32.load offset=20
            local.set 5
          end
          local.get 5
          local.get 3
          local.get 2
          call 7
          local.get 1
          local.get 1
          i32.load offset=20
          local.get 2
          i32.add
          i32.store offset=20
        end
      end
    end)
  (func (;5;) (type 0) (param i32) (result i32)
    (local i32 i32 i32)
    local.get 0
    local.set 1
    block  ;; label = @1
      local.get 0
      i32.const 3
      i32.and
      if  ;; label = @2
        loop  ;; label = @3
          local.get 1
          i32.load8_u
          i32.eqz
          br_if 2 (;@1;)
          local.get 1
          i32.const 1
          i32.add
          local.tee 1
          i32.const 3
          i32.and
          br_if 0 (;@3;)
        end
      end
      loop  ;; label = @2
        local.get 1
        local.tee 2
        i32.const 4
        i32.add
        local.set 1
        local.get 2
        i32.load
        local.tee 3
        i32.const -1
        i32.xor
        local.get 3
        i32.const 16843009
        i32.sub
        i32.and
        i32.const -2139062144
        i32.and
        i32.eqz
        br_if 0 (;@2;)
      end
      local.get 3
      i32.const 255
      i32.and
      i32.eqz
      if  ;; label = @2
        local.get 2
        local.get 0
        i32.sub
        return
      end
      loop  ;; label = @2
        local.get 2
        i32.load8_u offset=1
        local.set 3
        local.get 2
        i32.const 1
        i32.add
        local.tee 1
        local.set 2
        local.get 3
        br_if 0 (;@2;)
      end
    end
    local.get 1
    local.get 0
    i32.sub)
  (func (;6;) (type 1) (param i32 i32 i32) (result i32)
    (local i32)
    local.get 2
    if  ;; label = @1
      local.get 0
      local.set 3
      loop  ;; label = @2
        local.get 3
        local.get 1
        i32.store8
        local.get 3
        i32.const 1
        i32.add
        local.set 3
        local.get 2
        i32.const 1
        i32.sub
        local.tee 2
        br_if 0 (;@2;)
      end
    end
    local.get 0)
  (func (;7;) (type 2) (param i32 i32 i32)
    local.get 2
    if  ;; label = @1
      loop  ;; label = @2
        local.get 0
        local.get 1
        i32.load8_u
        i32.store8
        local.get 0
        i32.const 1
        i32.add
        local.set 0
        local.get 1
        i32.const 1
        i32.add
        local.set 1
        local.get 2
        i32.const 1
        i32.sub
        local.tee 2
        br_if 0 (;@2;)
      end
    end)
  (func (;8;) (type 0) (param i32) (result i32)
    local.get 0
    i32.const 48
    i32.sub
    i32.const 10
    i32.lt_u)
  (func (;9;) (type 5) (param i32 i32) (result i32)
    (local i32 i32)
    block  ;; label = @1
      block  ;; label = @2
        local.get 1
        local.get 0
        call 5
        local.get 0
        i32.add
        local.tee 3
        i32.xor
        i32.const 3
        i32.and
        br_if 0 (;@2;)
        local.get 1
        i32.const 3
        i32.and
        if  ;; label = @3
          loop  ;; label = @4
            local.get 3
            local.get 1
            i32.load8_u
            local.tee 2
            i32.store8
            local.get 2
            i32.eqz
            br_if 3 (;@1;)
            local.get 3
            i32.const 1
            i32.add
            local.set 3
            local.get 1
            i32.const 1
            i32.add
            local.tee 1
            i32.const 3
            i32.and
            br_if 0 (;@4;)
          end
        end
        local.get 1
        i32.load
        local.tee 2
        i32.const -1
        i32.xor
        local.get 2
        i32.const 16843009
        i32.sub
        i32.and
        i32.const -2139062144
        i32.and
        br_if 0 (;@2;)
        loop  ;; label = @3
          local.get 3
          local.get 2
          i32.store
          local.get 1
          i32.load offset=4
          local.set 2
          local.get 3
          i32.const 4
          i32.add
          local.set 3
          local.get 1
          i32.const 4
          i32.add
          local.set 1
          local.get 2
          i32.const 16843009
          i32.sub
          local.get 2
          i32.const -1
          i32.xor
          i32.and
          i32.const -2139062144
          i32.and
          i32.eqz
          br_if 0 (;@3;)
        end
      end
      local.get 3
      local.get 1
      i32.load8_u
      local.tee 2
      i32.store8
      local.get 2
      i32.eqz
      br_if 0 (;@1;)
      loop  ;; label = @2
        local.get 3
        local.get 1
        i32.load8_u offset=1
        local.tee 2
        i32.store8 offset=1
        local.get 3
        i32.const 1
        i32.add
        local.set 3
        local.get 1
        i32.const 1
        i32.add
        local.set 1
        local.get 2
        br_if 0 (;@2;)
      end
    end
    local.get 0)
  (func (;10;) (type 7) (param i32 i32 i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i64 i64)
    global.get 0
    i32.const 80
    i32.sub
    local.tee 5
    global.set 0
    local.get 5
    i32.const 1152
    i32.store offset=76
    local.get 5
    i32.const 55
    i32.add
    local.set 19
    local.get 5
    i32.const 56
    i32.add
    local.set 17
    block  ;; label = @1
      loop  ;; label = @2
        block  ;; label = @3
          local.get 14
          i32.const 0
          i32.lt_s
          br_if 0 (;@3;)
          i32.const 2147483647
          local.get 14
          i32.sub
          local.get 4
          i32.lt_s
          if  ;; label = @4
            i32.const 2564
            i32.const 61
            i32.store
            i32.const -1
            local.set 14
            br 1 (;@3;)
          end
          local.get 4
          local.get 14
          i32.add
          local.set 14
        end
        local.get 5
        i32.load offset=76
        local.tee 11
        local.set 4
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              local.get 11
              i32.load8_u
              local.tee 6
              if  ;; label = @6
                loop  ;; label = @7
                  block  ;; label = @8
                    block  ;; label = @9
                      local.get 6
                      i32.const 255
                      i32.and
                      local.tee 6
                      i32.eqz
                      if  ;; label = @10
                        local.get 4
                        local.set 6
                        br 1 (;@9;)
                      end
                      local.get 6
                      i32.const 37
                      i32.ne
                      br_if 1 (;@8;)
                      local.get 4
                      local.set 6
                      loop  ;; label = @10
                        local.get 4
                        i32.load8_u offset=1
                        i32.const 37
                        i32.ne
                        br_if 1 (;@9;)
                        local.get 5
                        local.get 4
                        i32.const 2
                        i32.add
                        local.tee 7
                        i32.store offset=76
                        local.get 6
                        i32.const 1
                        i32.add
                        local.set 6
                        local.get 4
                        i32.load8_u offset=2
                        local.set 8
                        local.get 7
                        local.set 4
                        local.get 8
                        i32.const 37
                        i32.eq
                        br_if 0 (;@10;)
                      end
                    end
                    local.get 6
                    local.get 11
                    i32.sub
                    local.set 4
                    local.get 0
                    if  ;; label = @9
                      local.get 0
                      local.get 11
                      local.get 4
                      call 4
                    end
                    local.get 4
                    br_if 6 (;@2;)
                    i32.const -1
                    local.set 16
                    i32.const 1
                    local.set 6
                    local.get 5
                    i32.load offset=76
                    i32.load8_s offset=1
                    call 8
                    local.set 4
                    local.get 5
                    i32.load offset=76
                    local.set 7
                    block  ;; label = @9
                      local.get 4
                      i32.eqz
                      br_if 0 (;@9;)
                      local.get 7
                      i32.load8_u offset=2
                      i32.const 36
                      i32.ne
                      br_if 0 (;@9;)
                      local.get 7
                      i32.load8_s offset=1
                      i32.const 48
                      i32.sub
                      local.set 16
                      i32.const 1
                      local.set 18
                      i32.const 3
                      local.set 6
                    end
                    local.get 5
                    local.get 6
                    local.get 7
                    i32.add
                    local.tee 4
                    i32.store offset=76
                    i32.const 0
                    local.set 15
                    block  ;; label = @9
                      local.get 4
                      i32.load8_s
                      local.tee 9
                      i32.const 32
                      i32.sub
                      local.tee 7
                      i32.const 31
                      i32.gt_u
                      if  ;; label = @10
                        local.get 4
                        local.set 6
                        br 1 (;@9;)
                      end
                      local.get 4
                      local.set 6
                      i32.const 1
                      local.get 7
                      i32.shl
                      local.tee 8
                      i32.const 75913
                      i32.and
                      i32.eqz
                      br_if 0 (;@9;)
                      loop  ;; label = @10
                        local.get 5
                        local.get 4
                        i32.const 1
                        i32.add
                        local.tee 6
                        i32.store offset=76
                        local.get 8
                        local.get 15
                        i32.or
                        local.set 15
                        local.get 4
                        i32.load8_s offset=1
                        local.tee 9
                        i32.const 32
                        i32.sub
                        local.tee 7
                        i32.const 32
                        i32.ge_u
                        br_if 1 (;@9;)
                        local.get 6
                        local.set 4
                        i32.const 1
                        local.get 7
                        i32.shl
                        local.tee 8
                        i32.const 75913
                        i32.and
                        br_if 0 (;@10;)
                      end
                    end
                    block  ;; label = @9
                      local.get 9
                      i32.const 42
                      i32.eq
                      if  ;; label = @10
                        local.get 5
                        block (result i32)  ;; label = @11
                          block  ;; label = @12
                            local.get 6
                            i32.load8_s offset=1
                            call 8
                            i32.eqz
                            br_if 0 (;@12;)
                            local.get 5
                            i32.load offset=76
                            local.tee 4
                            i32.load8_u offset=2
                            i32.const 36
                            i32.ne
                            br_if 0 (;@12;)
                            local.get 4
                            i32.load8_s offset=1
                            i32.const 2
                            i32.shl
                            local.get 3
                            i32.add
                            i32.const 192
                            i32.sub
                            i32.const 10
                            i32.store
                            local.get 4
                            i32.load8_s offset=1
                            i32.const 3
                            i32.shl
                            local.get 2
                            i32.add
                            i32.const 384
                            i32.sub
                            i32.load
                            local.set 12
                            i32.const 1
                            local.set 18
                            local.get 4
                            i32.const 3
                            i32.add
                            br 1 (;@11;)
                          end
                          local.get 18
                          br_if 6 (;@5;)
                          i32.const 0
                          local.set 18
                          i32.const 0
                          local.set 12
                          local.get 0
                          if  ;; label = @12
                            local.get 1
                            local.get 1
                            i32.load
                            local.tee 4
                            i32.const 4
                            i32.add
                            i32.store
                            local.get 4
                            i32.load
                            local.set 12
                          end
                          local.get 5
                          i32.load offset=76
                          i32.const 1
                          i32.add
                        end
                        local.tee 4
                        i32.store offset=76
                        local.get 12
                        i32.const -1
                        i32.gt_s
                        br_if 1 (;@9;)
                        i32.const 0
                        local.get 12
                        i32.sub
                        local.set 12
                        local.get 15
                        i32.const 8192
                        i32.or
                        local.set 15
                        br 1 (;@9;)
                      end
                      local.get 5
                      i32.const 76
                      i32.add
                      call 17
                      local.tee 12
                      i32.const 0
                      i32.lt_s
                      br_if 4 (;@5;)
                      local.get 5
                      i32.load offset=76
                      local.set 4
                    end
                    i32.const -1
                    local.set 10
                    block  ;; label = @9
                      local.get 4
                      i32.load8_u
                      i32.const 46
                      i32.ne
                      br_if 0 (;@9;)
                      local.get 4
                      i32.load8_u offset=1
                      i32.const 42
                      i32.eq
                      if  ;; label = @10
                        block  ;; label = @11
                          local.get 4
                          i32.load8_s offset=2
                          call 8
                          i32.eqz
                          br_if 0 (;@11;)
                          local.get 5
                          i32.load offset=76
                          local.tee 4
                          i32.load8_u offset=3
                          i32.const 36
                          i32.ne
                          br_if 0 (;@11;)
                          local.get 4
                          i32.load8_s offset=2
                          i32.const 2
                          i32.shl
                          local.get 3
                          i32.add
                          i32.const 192
                          i32.sub
                          i32.const 10
                          i32.store
                          local.get 4
                          i32.load8_s offset=2
                          i32.const 3
                          i32.shl
                          local.get 2
                          i32.add
                          i32.const 384
                          i32.sub
                          i32.load
                          local.set 10
                          local.get 5
                          local.get 4
                          i32.const 4
                          i32.add
                          local.tee 4
                          i32.store offset=76
                          br 2 (;@9;)
                        end
                        local.get 18
                        br_if 5 (;@5;)
                        local.get 0
                        if (result i32)  ;; label = @11
                          local.get 1
                          local.get 1
                          i32.load
                          local.tee 4
                          i32.const 4
                          i32.add
                          i32.store
                          local.get 4
                          i32.load
                        else
                          i32.const 0
                        end
                        local.set 10
                        local.get 5
                        local.get 5
                        i32.load offset=76
                        i32.const 2
                        i32.add
                        local.tee 4
                        i32.store offset=76
                        br 1 (;@9;)
                      end
                      local.get 5
                      local.get 4
                      i32.const 1
                      i32.add
                      i32.store offset=76
                      local.get 5
                      i32.const 76
                      i32.add
                      call 17
                      local.set 10
                      local.get 5
                      i32.load offset=76
                      local.set 4
                    end
                    i32.const 0
                    local.set 6
                    loop  ;; label = @9
                      local.get 6
                      local.set 8
                      i32.const -1
                      local.set 13
                      local.get 4
                      i32.load8_s
                      i32.const 65
                      i32.sub
                      i32.const 57
                      i32.gt_u
                      br_if 8 (;@1;)
                      local.get 5
                      local.get 4
                      i32.const 1
                      i32.add
                      local.tee 9
                      i32.store offset=76
                      local.get 4
                      i32.load8_s
                      local.set 6
                      local.get 9
                      local.set 4
                      local.get 6
                      local.get 8
                      i32.const 58
                      i32.mul
                      i32.add
                      i32.const 1391
                      i32.add
                      i32.load8_u
                      local.tee 6
                      i32.const 1
                      i32.sub
                      i32.const 8
                      i32.lt_u
                      br_if 0 (;@9;)
                    end
                    block  ;; label = @9
                      block  ;; label = @10
                        local.get 6
                        i32.const 19
                        i32.ne
                        if  ;; label = @11
                          local.get 6
                          i32.eqz
                          br_if 10 (;@1;)
                          local.get 16
                          i32.const 0
                          i32.ge_s
                          if  ;; label = @12
                            local.get 3
                            local.get 16
                            i32.const 2
                            i32.shl
                            i32.add
                            local.get 6
                            i32.store
                            local.get 5
                            local.get 2
                            local.get 16
                            i32.const 3
                            i32.shl
                            i32.add
                            i64.load
                            i64.store offset=64
                            br 2 (;@10;)
                          end
                          local.get 0
                          i32.eqz
                          br_if 8 (;@3;)
                          local.get 5
                          i32.const -64
                          i32.sub
                          local.get 6
                          local.get 1
                          call 16
                          local.get 5
                          i32.load offset=76
                          local.set 9
                          br 2 (;@9;)
                        end
                        local.get 16
                        i32.const -1
                        i32.gt_s
                        br_if 9 (;@1;)
                      end
                      i32.const 0
                      local.set 4
                      local.get 0
                      i32.eqz
                      br_if 7 (;@2;)
                    end
                    local.get 15
                    i32.const -65537
                    i32.and
                    local.tee 7
                    local.get 15
                    local.get 15
                    i32.const 8192
                    i32.and
                    select
                    local.set 6
                    i32.const 0
                    local.set 13
                    i32.const 1157
                    local.set 16
                    local.get 17
                    local.set 15
                    block  ;; label = @9
                      block  ;; label = @10
                        block  ;; label = @11
                          block (result i32)  ;; label = @12
                            block  ;; label = @13
                              block  ;; label = @14
                                block  ;; label = @15
                                  block  ;; label = @16
                                    block (result i32)  ;; label = @17
                                      block  ;; label = @18
                                        block  ;; label = @19
                                          block  ;; label = @20
                                            block  ;; label = @21
                                              block  ;; label = @22
                                                block  ;; label = @23
                                                  block  ;; label = @24
                                                    local.get 9
                                                    i32.const 1
                                                    i32.sub
                                                    i32.load8_s
                                                    local.tee 4
                                                    i32.const -33
                                                    i32.and
                                                    local.get 4
                                                    local.get 4
                                                    i32.const 15
                                                    i32.and
                                                    i32.const 3
                                                    i32.eq
                                                    select
                                                    local.get 4
                                                    local.get 8
                                                    select
                                                    local.tee 4
                                                    i32.const 88
                                                    i32.sub
                                                    br_table 4 (;@20;) 20 (;@4;) 20 (;@4;) 20 (;@4;) 20 (;@4;) 20 (;@4;) 20 (;@4;) 20 (;@4;) 20 (;@4;) 14 (;@10;) 20 (;@4;) 15 (;@9;) 6 (;@18;) 14 (;@10;) 14 (;@10;) 14 (;@10;) 20 (;@4;) 6 (;@18;) 20 (;@4;) 20 (;@4;) 20 (;@4;) 20 (;@4;) 2 (;@22;) 5 (;@19;) 3 (;@21;) 20 (;@4;) 20 (;@4;) 9 (;@15;) 20 (;@4;) 1 (;@23;) 20 (;@4;) 20 (;@4;) 4 (;@20;) 0 (;@24;)
                                                  end
                                                  block  ;; label = @24
                                                    local.get 4
                                                    i32.const 65
                                                    i32.sub
                                                    br_table 14 (;@10;) 20 (;@4;) 11 (;@13;) 20 (;@4;) 14 (;@10;) 14 (;@10;) 14 (;@10;) 0 (;@24;)
                                                  end
                                                  local.get 4
                                                  i32.const 83
                                                  i32.eq
                                                  br_if 9 (;@14;)
                                                  br 19 (;@4;)
                                                end
                                                local.get 5
                                                i64.load offset=64
                                                local.set 20
                                                i32.const 1157
                                                br 5 (;@17;)
                                              end
                                              i32.const 0
                                              local.set 4
                                              block  ;; label = @22
                                                block  ;; label = @23
                                                  block  ;; label = @24
                                                    block  ;; label = @25
                                                      block  ;; label = @26
                                                        block  ;; label = @27
                                                          block  ;; label = @28
                                                            local.get 8
                                                            i32.const 255
                                                            i32.and
                                                            br_table 0 (;@28;) 1 (;@27;) 2 (;@26;) 3 (;@25;) 4 (;@24;) 26 (;@2;) 5 (;@23;) 6 (;@22;) 26 (;@2;)
                                                          end
                                                          local.get 5
                                                          i32.load offset=64
                                                          local.get 14
                                                          i32.store
                                                          br 25 (;@2;)
                                                        end
                                                        local.get 5
                                                        i32.load offset=64
                                                        local.get 14
                                                        i32.store
                                                        br 24 (;@2;)
                                                      end
                                                      local.get 5
                                                      i32.load offset=64
                                                      local.get 14
                                                      i64.extend_i32_s
                                                      i64.store
                                                      br 23 (;@2;)
                                                    end
                                                    local.get 5
                                                    i32.load offset=64
                                                    local.get 14
                                                    i32.store16
                                                    br 22 (;@2;)
                                                  end
                                                  local.get 5
                                                  i32.load offset=64
                                                  local.get 14
                                                  i32.store8
                                                  br 21 (;@2;)
                                                end
                                                local.get 5
                                                i32.load offset=64
                                                local.get 14
                                                i32.store
                                                br 20 (;@2;)
                                              end
                                              local.get 5
                                              i32.load offset=64
                                              local.get 14
                                              i64.extend_i32_s
                                              i64.store
                                              br 19 (;@2;)
                                            end
                                            local.get 10
                                            i32.const 8
                                            local.get 10
                                            i32.const 8
                                            i32.gt_u
                                            select
                                            local.set 10
                                            local.get 6
                                            i32.const 8
                                            i32.or
                                            local.set 6
                                            i32.const 120
                                            local.set 4
                                          end
                                          local.get 17
                                          local.set 7
                                          local.get 4
                                          i32.const 32
                                          i32.and
                                          local.set 8
                                          local.get 5
                                          i64.load offset=64
                                          local.tee 20
                                          i64.eqz
                                          i32.eqz
                                          if  ;; label = @20
                                            loop  ;; label = @21
                                              local.get 7
                                              i32.const 1
                                              i32.sub
                                              local.tee 7
                                              local.get 20
                                              i32.wrap_i64
                                              i32.const 15
                                              i32.and
                                              i32.const 1920
                                              i32.add
                                              i32.load8_u
                                              local.get 8
                                              i32.or
                                              i32.store8
                                              local.get 20
                                              i64.const 15
                                              i64.gt_u
                                              local.set 11
                                              local.get 20
                                              i64.const 4
                                              i64.shr_u
                                              local.set 20
                                              local.get 11
                                              br_if 0 (;@21;)
                                            end
                                          end
                                          local.get 7
                                          local.set 11
                                          local.get 6
                                          i32.const 8
                                          i32.and
                                          i32.eqz
                                          local.get 5
                                          i64.load offset=64
                                          i64.eqz
                                          i32.or
                                          br_if 3 (;@16;)
                                          local.get 4
                                          i32.const 4
                                          i32.shr_u
                                          i32.const 1157
                                          i32.add
                                          local.set 16
                                          i32.const 2
                                          local.set 13
                                          br 3 (;@16;)
                                        end
                                        local.get 17
                                        local.set 4
                                        local.get 5
                                        i64.load offset=64
                                        local.tee 20
                                        i64.eqz
                                        i32.eqz
                                        if  ;; label = @19
                                          loop  ;; label = @20
                                            local.get 4
                                            i32.const 1
                                            i32.sub
                                            local.tee 4
                                            local.get 20
                                            i32.wrap_i64
                                            i32.const 7
                                            i32.and
                                            i32.const 48
                                            i32.or
                                            i32.store8
                                            local.get 20
                                            i64.const 7
                                            i64.gt_u
                                            local.set 7
                                            local.get 20
                                            i64.const 3
                                            i64.shr_u
                                            local.set 20
                                            local.get 7
                                            br_if 0 (;@20;)
                                          end
                                        end
                                        local.get 4
                                        local.set 11
                                        local.get 6
                                        i32.const 8
                                        i32.and
                                        i32.eqz
                                        br_if 2 (;@16;)
                                        local.get 10
                                        local.get 17
                                        local.get 11
                                        i32.sub
                                        local.tee 4
                                        i32.const 1
                                        i32.add
                                        local.get 4
                                        local.get 10
                                        i32.lt_s
                                        select
                                        local.set 10
                                        br 2 (;@16;)
                                      end
                                      local.get 5
                                      i64.load offset=64
                                      local.tee 20
                                      i64.const -1
                                      i64.le_s
                                      if  ;; label = @18
                                        local.get 5
                                        i64.const 0
                                        local.get 20
                                        i64.sub
                                        local.tee 20
                                        i64.store offset=64
                                        i32.const 1
                                        local.set 13
                                        i32.const 1157
                                        br 1 (;@17;)
                                      end
                                      local.get 6
                                      i32.const 2048
                                      i32.and
                                      if  ;; label = @18
                                        i32.const 1
                                        local.set 13
                                        i32.const 1158
                                        br 1 (;@17;)
                                      end
                                      i32.const 1159
                                      i32.const 1157
                                      local.get 6
                                      i32.const 1
                                      i32.and
                                      local.tee 13
                                      select
                                    end
                                    local.set 16
                                    local.get 17
                                    local.set 11
                                    block  ;; label = @17
                                      local.get 20
                                      i64.const 4294967296
                                      i64.lt_u
                                      if  ;; label = @18
                                        local.get 20
                                        local.set 21
                                        br 1 (;@17;)
                                      end
                                      loop  ;; label = @18
                                        local.get 11
                                        i32.const 1
                                        i32.sub
                                        local.tee 11
                                        local.get 20
                                        local.get 20
                                        i64.const 10
                                        i64.div_u
                                        local.tee 21
                                        i64.const 10
                                        i64.mul
                                        i64.sub
                                        i32.wrap_i64
                                        i32.const 48
                                        i32.or
                                        i32.store8
                                        local.get 20
                                        i64.const 42949672959
                                        i64.gt_u
                                        local.set 4
                                        local.get 21
                                        local.set 20
                                        local.get 4
                                        br_if 0 (;@18;)
                                      end
                                    end
                                    local.get 21
                                    i32.wrap_i64
                                    local.tee 7
                                    if  ;; label = @17
                                      loop  ;; label = @18
                                        local.get 11
                                        i32.const 1
                                        i32.sub
                                        local.tee 11
                                        local.get 7
                                        local.get 7
                                        i32.const 10
                                        i32.div_u
                                        local.tee 4
                                        i32.const 10
                                        i32.mul
                                        i32.sub
                                        i32.const 48
                                        i32.or
                                        i32.store8
                                        local.get 7
                                        i32.const 9
                                        i32.gt_u
                                        local.set 8
                                        local.get 4
                                        local.set 7
                                        local.get 8
                                        br_if 0 (;@18;)
                                      end
                                    end
                                  end
                                  local.get 6
                                  i32.const -65537
                                  i32.and
                                  local.get 6
                                  local.get 10
                                  i32.const -1
                                  i32.gt_s
                                  select
                                  local.set 6
                                  local.get 5
                                  i64.load offset=64
                                  local.tee 20
                                  i64.const 0
                                  i64.ne
                                  local.get 10
                                  i32.or
                                  i32.eqz
                                  if  ;; label = @16
                                    i32.const 0
                                    local.set 10
                                    local.get 17
                                    local.set 11
                                    br 12 (;@4;)
                                  end
                                  local.get 10
                                  local.get 20
                                  i64.eqz
                                  local.get 17
                                  local.get 11
                                  i32.sub
                                  i32.add
                                  local.tee 4
                                  local.get 4
                                  local.get 10
                                  i32.lt_s
                                  select
                                  local.set 10
                                  br 11 (;@4;)
                                end
                                block (result i32)  ;; label = @15
                                  local.get 10
                                  local.tee 4
                                  i32.const 0
                                  i32.ne
                                  local.set 8
                                  block  ;; label = @16
                                    block  ;; label = @17
                                      block  ;; label = @18
                                        local.get 5
                                        i32.load offset=64
                                        local.tee 6
                                        i32.const 1167
                                        local.get 6
                                        select
                                        local.tee 11
                                        local.tee 9
                                        i32.const 3
                                        i32.and
                                        i32.eqz
                                        local.get 4
                                        i32.eqz
                                        i32.or
                                        br_if 0 (;@18;)
                                        loop  ;; label = @19
                                          local.get 9
                                          i32.load8_u
                                          i32.eqz
                                          br_if 2 (;@17;)
                                          local.get 4
                                          i32.const 1
                                          i32.sub
                                          local.tee 4
                                          i32.const 0
                                          i32.ne
                                          local.set 8
                                          local.get 9
                                          i32.const 1
                                          i32.add
                                          local.tee 9
                                          i32.const 3
                                          i32.and
                                          i32.eqz
                                          br_if 1 (;@18;)
                                          local.get 4
                                          br_if 0 (;@19;)
                                        end
                                      end
                                      local.get 8
                                      i32.eqz
                                      br_if 1 (;@16;)
                                    end
                                    block  ;; label = @17
                                      local.get 9
                                      i32.load8_u
                                      i32.eqz
                                      local.get 4
                                      i32.const 4
                                      i32.lt_u
                                      i32.or
                                      br_if 0 (;@17;)
                                      loop  ;; label = @18
                                        local.get 9
                                        i32.load
                                        local.tee 6
                                        i32.const -1
                                        i32.xor
                                        local.get 6
                                        i32.const 16843009
                                        i32.sub
                                        i32.and
                                        i32.const -2139062144
                                        i32.and
                                        br_if 1 (;@17;)
                                        local.get 9
                                        i32.const 4
                                        i32.add
                                        local.set 9
                                        local.get 4
                                        i32.const 4
                                        i32.sub
                                        local.tee 4
                                        i32.const 3
                                        i32.gt_u
                                        br_if 0 (;@18;)
                                      end
                                    end
                                    local.get 4
                                    i32.eqz
                                    br_if 0 (;@16;)
                                    loop  ;; label = @17
                                      local.get 9
                                      local.get 9
                                      i32.load8_u
                                      i32.eqz
                                      br_if 2 (;@15;)
                                      drop
                                      local.get 9
                                      i32.const 1
                                      i32.add
                                      local.set 9
                                      local.get 4
                                      i32.const 1
                                      i32.sub
                                      local.tee 4
                                      br_if 0 (;@17;)
                                    end
                                  end
                                  i32.const 0
                                end
                                local.tee 4
                                local.get 10
                                local.get 11
                                i32.add
                                local.get 4
                                select
                                local.set 15
                                local.get 7
                                local.set 6
                                local.get 4
                                local.get 11
                                i32.sub
                                local.get 10
                                local.get 4
                                select
                                local.set 10
                                br 10 (;@4;)
                              end
                              local.get 10
                              if  ;; label = @14
                                local.get 5
                                i32.load offset=64
                                br 2 (;@12;)
                              end
                              i32.const 0
                              local.set 4
                              local.get 0
                              i32.const 32
                              local.get 12
                              i32.const 0
                              local.get 6
                              call 3
                              br 2 (;@11;)
                            end
                            local.get 5
                            i32.const 0
                            i32.store offset=12
                            local.get 5
                            local.get 5
                            i64.load offset=64
                            i64.store32 offset=8
                            local.get 5
                            local.get 5
                            i32.const 8
                            i32.add
                            i32.store offset=64
                            i32.const -1
                            local.set 10
                            local.get 5
                            i32.const 8
                            i32.add
                          end
                          local.set 8
                          i32.const 0
                          local.set 4
                          block  ;; label = @12
                            loop  ;; label = @13
                              local.get 8
                              i32.load
                              local.tee 7
                              i32.eqz
                              br_if 1 (;@12;)
                              local.get 5
                              i32.const 4
                              i32.add
                              local.get 7
                              call 15
                              local.tee 11
                              i32.const 0
                              i32.lt_s
                              local.tee 7
                              local.get 11
                              local.get 10
                              local.get 4
                              i32.sub
                              i32.gt_u
                              i32.or
                              i32.eqz
                              if  ;; label = @14
                                local.get 8
                                i32.const 4
                                i32.add
                                local.set 8
                                local.get 10
                                local.get 4
                                local.get 11
                                i32.add
                                local.tee 4
                                i32.gt_u
                                br_if 1 (;@13;)
                                br 2 (;@12;)
                              end
                            end
                            i32.const -1
                            local.set 13
                            local.get 7
                            br_if 11 (;@1;)
                          end
                          local.get 0
                          i32.const 32
                          local.get 12
                          local.get 4
                          local.get 6
                          call 3
                          local.get 4
                          i32.eqz
                          if  ;; label = @12
                            i32.const 0
                            local.set 4
                            br 1 (;@11;)
                          end
                          i32.const 0
                          local.set 8
                          local.get 5
                          i32.load offset=64
                          local.set 9
                          loop  ;; label = @12
                            local.get 9
                            i32.load
                            local.tee 7
                            i32.eqz
                            br_if 1 (;@11;)
                            local.get 5
                            i32.const 4
                            i32.add
                            local.get 7
                            call 15
                            local.tee 7
                            local.get 8
                            i32.add
                            local.tee 8
                            local.get 4
                            i32.gt_s
                            br_if 1 (;@11;)
                            local.get 0
                            local.get 5
                            i32.const 4
                            i32.add
                            local.get 7
                            call 4
                            local.get 9
                            i32.const 4
                            i32.add
                            local.set 9
                            local.get 4
                            local.get 8
                            i32.gt_u
                            br_if 0 (;@12;)
                          end
                        end
                        local.get 0
                        i32.const 32
                        local.get 12
                        local.get 4
                        local.get 6
                        i32.const 8192
                        i32.xor
                        call 3
                        local.get 12
                        local.get 4
                        local.get 4
                        local.get 12
                        i32.lt_s
                        select
                        local.set 4
                        br 8 (;@2;)
                      end
                      local.get 0
                      local.get 5
                      f64.load offset=64
                      local.get 12
                      local.get 10
                      local.get 6
                      local.get 4
                      i32.const 0
                      call_indirect (type 8)
                      local.set 4
                      br 7 (;@2;)
                    end
                    local.get 5
                    local.get 5
                    i64.load offset=64
                    i64.store8 offset=55
                    i32.const 1
                    local.set 10
                    local.get 19
                    local.set 11
                    local.get 7
                    local.set 6
                    br 4 (;@4;)
                  end
                  local.get 5
                  local.get 4
                  i32.const 1
                  i32.add
                  local.tee 7
                  i32.store offset=76
                  local.get 4
                  i32.load8_u offset=1
                  local.set 6
                  local.get 7
                  local.set 4
                  br 0 (;@7;)
                end
                unreachable
              end
              local.get 14
              local.set 13
              local.get 0
              br_if 4 (;@1;)
              local.get 18
              i32.eqz
              br_if 2 (;@3;)
              i32.const 1
              local.set 4
              loop  ;; label = @6
                local.get 3
                local.get 4
                i32.const 2
                i32.shl
                i32.add
                i32.load
                local.tee 0
                if  ;; label = @7
                  local.get 2
                  local.get 4
                  i32.const 3
                  i32.shl
                  i32.add
                  local.get 0
                  local.get 1
                  call 16
                  i32.const 1
                  local.set 13
                  local.get 4
                  i32.const 1
                  i32.add
                  local.tee 4
                  i32.const 10
                  i32.ne
                  br_if 1 (;@6;)
                  br 6 (;@1;)
                end
              end
              i32.const 1
              local.set 13
              local.get 4
              i32.const 10
              i32.ge_u
              br_if 4 (;@1;)
              loop  ;; label = @6
                local.get 3
                local.get 4
                i32.const 2
                i32.shl
                i32.add
                i32.load
                br_if 1 (;@5;)
                local.get 4
                i32.const 1
                i32.add
                local.tee 4
                i32.const 10
                i32.ne
                br_if 0 (;@6;)
              end
              br 4 (;@1;)
            end
            i32.const -1
            local.set 13
            br 3 (;@1;)
          end
          local.get 0
          i32.const 32
          local.get 13
          local.get 15
          local.get 11
          i32.sub
          local.tee 8
          local.get 10
          local.get 8
          local.get 10
          i32.gt_s
          select
          local.tee 7
          i32.add
          local.tee 9
          local.get 12
          local.get 9
          local.get 12
          i32.gt_s
          select
          local.tee 4
          local.get 9
          local.get 6
          call 3
          local.get 0
          local.get 16
          local.get 13
          call 4
          local.get 0
          i32.const 48
          local.get 4
          local.get 9
          local.get 6
          i32.const 65536
          i32.xor
          call 3
          local.get 0
          i32.const 48
          local.get 7
          local.get 8
          i32.const 0
          call 3
          local.get 0
          local.get 11
          local.get 8
          call 4
          local.get 0
          i32.const 32
          local.get 4
          local.get 9
          local.get 6
          i32.const 8192
          i32.xor
          call 3
          br 1 (;@2;)
        end
      end
      i32.const 0
      local.set 13
    end
    local.get 5
    i32.const 80
    i32.add
    global.set 0
    local.get 13)
  (func (;11;) (type 3) (param i32 i32)
    (local i32)
    local.get 1
    i32.const 0
    local.get 1
    i32.const 0
    i32.gt_s
    select
    local.set 2
    i32.const 0
    local.set 1
    loop  ;; label = @1
      local.get 1
      local.get 2
      i32.ne
      if  ;; label = @2
        local.get 0
        local.get 1
        i32.add
        i32.const 0
        i32.store8
        local.get 1
        i32.const 1
        i32.add
        local.set 1
        br 1 (;@1;)
      end
    end)
  (func (;12;) (type 2) (param i32 i32 i32)
    (local i32 i32 i32)
    local.get 0
    local.get 0
    i32.load
    local.tee 3
    local.get 2
    i32.const 3
    i32.shl
    i32.add
    local.tee 4
    i32.store
    local.get 0
    local.get 0
    i32.load offset=4
    local.get 3
    local.get 4
    i32.gt_u
    i32.add
    local.get 2
    i32.const 29
    i32.shr_u
    i32.add
    i32.store offset=4
    block  ;; label = @1
      local.get 2
      i32.const 64
      local.get 3
      i32.const 3
      i32.shr_u
      i32.const 63
      i32.and
      local.tee 4
      i32.sub
      local.tee 3
      i32.lt_u
      if  ;; label = @2
        i32.const 0
        local.set 3
        br 1 (;@1;)
      end
      local.get 4
      local.get 0
      i32.const 24
      i32.add
      local.tee 4
      i32.add
      local.get 1
      local.get 3
      call 7
      local.get 0
      i32.const 8
      i32.add
      local.tee 5
      local.get 4
      call 18
      loop (result i32)  ;; label = @2
        local.get 2
        local.get 3
        i32.const -64
        i32.sub
        local.tee 4
        i32.lt_u
        if (result i32)  ;; label = @3
          i32.const 0
        else
          local.get 5
          local.get 1
          local.get 3
          i32.add
          call 18
          local.get 4
          local.set 3
          br 1 (;@2;)
        end
      end
      local.set 4
    end
    local.get 0
    local.get 4
    i32.add
    i32.const 24
    i32.add
    local.get 1
    local.get 3
    i32.add
    local.get 2
    local.get 3
    i32.sub
    call 7)
  (func (;13;) (type 9)
    nop)
  (func (;14;) (type 2) (param i32 i32 i32)
    (local i32 i32 i32)
    local.get 2
    i32.const 3
    i32.add
    i32.const 2
    i32.shr_u
    local.set 5
    i32.const 0
    local.set 2
    loop  ;; label = @1
      local.get 3
      local.get 5
      i32.eq
      i32.eqz
      if  ;; label = @2
        local.get 0
        local.get 2
        i32.add
        local.get 1
        local.get 3
        i32.const 2
        i32.shl
        i32.add
        local.tee 4
        i32.load
        i32.store8
        local.get 0
        local.get 2
        i32.const 1
        i32.or
        i32.add
        local.get 4
        i32.load
        i32.const 8
        i32.shr_u
        i32.store8
        local.get 0
        local.get 2
        i32.const 2
        i32.or
        i32.add
        local.get 4
        i32.load16_u offset=2
        i32.store8
        local.get 0
        local.get 2
        i32.const 3
        i32.or
        i32.add
        local.get 4
        i32.load8_u offset=3
        i32.store8
        local.get 2
        i32.const 4
        i32.add
        local.set 2
        local.get 3
        i32.const 1
        i32.add
        local.set 3
        br 1 (;@1;)
      end
    end)
  (func (;15;) (type 5) (param i32 i32) (result i32)
    local.get 0
    i32.eqz
    if  ;; label = @1
      i32.const 0
      return
    end
    block (result i32)  ;; label = @1
      block  ;; label = @2
        local.get 0
        if (result i32)  ;; label = @3
          local.get 1
          i32.const 127
          i32.le_u
          br_if 1 (;@2;)
          block  ;; label = @4
            i32.const 2172
            i32.load
            i32.load
            i32.eqz
            if  ;; label = @5
              local.get 1
              i32.const -128
              i32.and
              i32.const 57216
              i32.eq
              br_if 3 (;@2;)
              br 1 (;@4;)
            end
            local.get 1
            i32.const 2047
            i32.le_u
            if  ;; label = @5
              local.get 0
              local.get 1
              i32.const 63
              i32.and
              i32.const 128
              i32.or
              i32.store8 offset=1
              local.get 0
              local.get 1
              i32.const 6
              i32.shr_u
              i32.const 192
              i32.or
              i32.store8
              i32.const 2
              br 4 (;@1;)
            end
            local.get 1
            i32.const 55296
            i32.ge_u
            i32.const 0
            local.get 1
            i32.const -8192
            i32.and
            i32.const 57344
            i32.ne
            select
            i32.eqz
            if  ;; label = @5
              local.get 0
              local.get 1
              i32.const 63
              i32.and
              i32.const 128
              i32.or
              i32.store8 offset=2
              local.get 0
              local.get 1
              i32.const 12
              i32.shr_u
              i32.const 224
              i32.or
              i32.store8
              local.get 0
              local.get 1
              i32.const 6
              i32.shr_u
              i32.const 63
              i32.and
              i32.const 128
              i32.or
              i32.store8 offset=1
              i32.const 3
              br 4 (;@1;)
            end
            local.get 1
            i32.const 65536
            i32.sub
            i32.const 1048575
            i32.le_u
            if  ;; label = @5
              local.get 0
              local.get 1
              i32.const 63
              i32.and
              i32.const 128
              i32.or
              i32.store8 offset=3
              local.get 0
              local.get 1
              i32.const 18
              i32.shr_u
              i32.const 240
              i32.or
              i32.store8
              local.get 0
              local.get 1
              i32.const 6
              i32.shr_u
              i32.const 63
              i32.and
              i32.const 128
              i32.or
              i32.store8 offset=2
              local.get 0
              local.get 1
              i32.const 12
              i32.shr_u
              i32.const 63
              i32.and
              i32.const 128
              i32.or
              i32.store8 offset=1
              i32.const 4
              br 4 (;@1;)
            end
          end
          i32.const 2564
          i32.const 25
          i32.store
          i32.const -1
        else
          i32.const 1
        end
        br 1 (;@1;)
      end
      local.get 0
      local.get 1
      i32.store8
      i32.const 1
    end)
  (func (;16;) (type 2) (param i32 i32 i32)
    block  ;; label = @1
      local.get 1
      i32.const 20
      i32.gt_u
      br_if 0 (;@1;)
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              block  ;; label = @6
                block  ;; label = @7
                  block  ;; label = @8
                    block  ;; label = @9
                      block  ;; label = @10
                        block  ;; label = @11
                          local.get 1
                          i32.const 9
                          i32.sub
                          br_table 0 (;@11;) 1 (;@10;) 2 (;@9;) 3 (;@8;) 4 (;@7;) 5 (;@6;) 6 (;@5;) 7 (;@4;) 8 (;@3;) 9 (;@2;) 10 (;@1;)
                        end
                        local.get 2
                        local.get 2
                        i32.load
                        local.tee 1
                        i32.const 4
                        i32.add
                        i32.store
                        local.get 0
                        local.get 1
                        i32.load
                        i32.store
                        return
                      end
                      local.get 2
                      local.get 2
                      i32.load
                      local.tee 1
                      i32.const 4
                      i32.add
                      i32.store
                      local.get 0
                      local.get 1
                      i64.load32_s
                      i64.store
                      return
                    end
                    local.get 2
                    local.get 2
                    i32.load
                    local.tee 1
                    i32.const 4
                    i32.add
                    i32.store
                    local.get 0
                    local.get 1
                    i64.load32_u
                    i64.store
                    return
                  end
                  local.get 2
                  local.get 2
                  i32.load
                  i32.const 7
                  i32.add
                  i32.const -8
                  i32.and
                  local.tee 1
                  i32.const 8
                  i32.add
                  i32.store
                  local.get 0
                  local.get 1
                  i64.load
                  i64.store
                  return
                end
                local.get 2
                local.get 2
                i32.load
                local.tee 1
                i32.const 4
                i32.add
                i32.store
                local.get 0
                local.get 1
                i64.load16_s
                i64.store
                return
              end
              local.get 2
              local.get 2
              i32.load
              local.tee 1
              i32.const 4
              i32.add
              i32.store
              local.get 0
              local.get 1
              i64.load16_u
              i64.store
              return
            end
            local.get 2
            local.get 2
            i32.load
            local.tee 1
            i32.const 4
            i32.add
            i32.store
            local.get 0
            local.get 1
            i64.load8_s
            i64.store
            return
          end
          local.get 2
          local.get 2
          i32.load
          local.tee 1
          i32.const 4
          i32.add
          i32.store
          local.get 0
          local.get 1
          i64.load8_u
          i64.store
          return
        end
        local.get 2
        local.get 2
        i32.load
        i32.const 7
        i32.add
        i32.const -8
        i32.and
        local.tee 1
        i32.const 8
        i32.add
        i32.store
        local.get 0
        local.get 1
        f64.load
        f64.store
        return
      end
      local.get 0
      local.get 2
      i32.const 0
      call_indirect (type 3)
    end)
  (func (;17;) (type 0) (param i32) (result i32)
    (local i32 i32 i32)
    local.get 0
    i32.load
    i32.load8_s
    call 8
    if  ;; label = @1
      loop  ;; label = @2
        local.get 0
        i32.load
        local.tee 2
        i32.load8_s
        local.set 3
        local.get 0
        local.get 2
        i32.const 1
        i32.add
        i32.store
        local.get 3
        local.get 1
        i32.const 10
        i32.mul
        i32.add
        i32.const 48
        i32.sub
        local.set 1
        local.get 2
        i32.load8_s offset=1
        call 8
        br_if 0 (;@2;)
      end
    end
    local.get 1)
  (func (;18;) (type 3) (param i32 i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    global.get 0
    i32.const 256
    i32.sub
    local.tee 6
    global.set 0
    local.get 0
    i32.load
    local.set 2
    local.get 0
    i32.load offset=8
    local.set 4
    local.get 0
    i32.load offset=12
    local.set 3
    local.get 0
    i32.load offset=4
    local.set 10
    loop  ;; label = @1
      local.get 7
      i32.const 16
      i32.ne
      if  ;; label = @2
        local.get 6
        local.get 7
        i32.const 2
        i32.shl
        i32.add
        local.get 1
        local.get 11
        i32.add
        i32.load8_u
        local.get 1
        local.get 11
        i32.const 1
        i32.or
        i32.add
        i32.load8_u
        i32.const 8
        i32.shl
        i32.or
        local.get 1
        local.get 11
        i32.const 2
        i32.or
        i32.add
        i32.load8_u
        i32.const 16
        i32.shl
        i32.or
        local.get 1
        local.get 11
        i32.const 3
        i32.or
        i32.add
        i32.load8_u
        i32.const 24
        i32.shl
        i32.or
        i32.store
        local.get 11
        i32.const 4
        i32.add
        local.set 11
        local.get 7
        i32.const 1
        i32.add
        local.set 7
        br 1 (;@1;)
      end
    end
    local.get 0
    local.get 6
    i32.load offset=16
    local.tee 13
    local.get 6
    i32.load offset=32
    local.tee 8
    local.get 6
    i32.load offset=48
    local.tee 14
    local.get 6
    i32.load
    local.tee 9
    local.get 6
    i32.load offset=36
    local.tee 15
    local.get 6
    i32.load offset=52
    local.tee 16
    local.get 6
    i32.load offset=4
    local.tee 17
    local.get 6
    i32.load offset=20
    local.tee 18
    local.get 16
    local.get 15
    local.get 18
    local.get 17
    local.get 14
    local.get 8
    local.get 13
    local.get 10
    local.get 9
    local.get 2
    local.get 4
    local.get 10
    i32.and
    i32.add
    local.get 3
    local.get 10
    i32.const -1
    i32.xor
    i32.and
    i32.add
    i32.add
    i32.const 680876936
    i32.sub
    i32.const 7
    i32.rotl
    i32.add
    local.tee 1
    i32.add
    local.get 3
    local.get 17
    i32.add
    local.get 4
    local.get 1
    i32.const -1
    i32.xor
    i32.and
    i32.add
    local.get 1
    local.get 10
    i32.and
    i32.add
    i32.const 389564586
    i32.sub
    i32.const 12
    i32.rotl
    local.get 1
    i32.add
    local.tee 3
    local.get 10
    local.get 6
    i32.load offset=12
    local.tee 19
    i32.add
    local.get 1
    local.get 3
    local.get 4
    local.get 6
    i32.load offset=8
    local.tee 20
    i32.add
    local.get 10
    local.get 3
    i32.const -1
    i32.xor
    i32.and
    i32.add
    local.get 1
    local.get 3
    i32.and
    i32.add
    i32.const 606105819
    i32.add
    i32.const 17
    i32.rotl
    i32.add
    local.tee 4
    i32.const -1
    i32.xor
    i32.and
    i32.add
    local.get 3
    local.get 4
    i32.and
    i32.add
    i32.const 1044525330
    i32.sub
    i32.const 22
    i32.rotl
    local.get 4
    i32.add
    local.tee 2
    i32.const -1
    i32.xor
    i32.and
    i32.add
    local.get 2
    local.get 4
    i32.and
    i32.add
    i32.const 176418897
    i32.sub
    i32.const 7
    i32.rotl
    local.get 2
    i32.add
    local.tee 1
    i32.add
    local.get 3
    local.get 18
    i32.add
    local.get 4
    local.get 1
    i32.const -1
    i32.xor
    i32.and
    i32.add
    local.get 1
    local.get 2
    i32.and
    i32.add
    i32.const 1200080426
    i32.add
    i32.const 12
    i32.rotl
    local.get 1
    i32.add
    local.tee 3
    local.get 6
    i32.load offset=28
    local.tee 21
    local.get 2
    i32.add
    local.get 1
    local.get 3
    local.get 6
    i32.load offset=24
    local.tee 22
    local.get 4
    i32.add
    local.get 2
    local.get 3
    i32.const -1
    i32.xor
    i32.and
    i32.add
    local.get 1
    local.get 3
    i32.and
    i32.add
    i32.const 1473231341
    i32.sub
    i32.const 17
    i32.rotl
    i32.add
    local.tee 4
    i32.const -1
    i32.xor
    i32.and
    i32.add
    local.get 3
    local.get 4
    i32.and
    i32.add
    i32.const 45705983
    i32.sub
    i32.const 22
    i32.rotl
    local.get 4
    i32.add
    local.tee 1
    i32.const -1
    i32.xor
    i32.and
    i32.add
    local.get 1
    local.get 4
    i32.and
    i32.add
    i32.const 1770035416
    i32.add
    i32.const 7
    i32.rotl
    local.get 1
    i32.add
    local.tee 2
    i32.add
    local.get 3
    local.get 15
    i32.add
    local.get 4
    local.get 2
    i32.const -1
    i32.xor
    i32.and
    i32.add
    local.get 1
    local.get 2
    i32.and
    i32.add
    i32.const 1958414417
    i32.sub
    i32.const 12
    i32.rotl
    local.get 2
    i32.add
    local.tee 3
    local.get 6
    i32.load offset=44
    local.tee 10
    local.get 1
    i32.add
    local.get 2
    local.get 3
    local.get 6
    i32.load offset=40
    local.tee 11
    local.get 4
    i32.add
    local.get 1
    local.get 3
    i32.const -1
    i32.xor
    i32.and
    i32.add
    local.get 2
    local.get 3
    i32.and
    i32.add
    i32.const 42063
    i32.sub
    i32.const 17
    i32.rotl
    i32.add
    local.tee 1
    i32.const -1
    i32.xor
    i32.and
    i32.add
    local.get 1
    local.get 3
    i32.and
    i32.add
    i32.const 1990404162
    i32.sub
    i32.const 22
    i32.rotl
    local.get 1
    i32.add
    local.tee 4
    i32.const -1
    i32.xor
    i32.and
    i32.add
    local.get 1
    local.get 4
    i32.and
    i32.add
    i32.const 1804603682
    i32.add
    i32.const 7
    i32.rotl
    local.get 4
    i32.add
    local.tee 2
    i32.add
    local.get 6
    i32.load offset=56
    local.tee 7
    local.get 1
    i32.add
    local.get 4
    local.get 3
    local.get 16
    i32.add
    local.get 1
    local.get 2
    i32.const -1
    i32.xor
    i32.and
    i32.add
    local.get 2
    local.get 4
    i32.and
    i32.add
    i32.const 40341101
    i32.sub
    i32.const 12
    i32.rotl
    local.get 2
    i32.add
    local.tee 5
    i32.const -1
    i32.xor
    local.tee 1
    i32.and
    i32.add
    local.get 2
    local.get 5
    i32.and
    i32.add
    i32.const 1502002290
    i32.sub
    i32.const 17
    i32.rotl
    local.get 5
    i32.add
    local.tee 3
    local.get 1
    i32.and
    i32.add
    local.get 4
    local.get 6
    i32.load offset=60
    local.tee 4
    i32.add
    local.get 2
    local.get 3
    i32.const -1
    i32.xor
    local.tee 1
    i32.and
    i32.add
    local.get 3
    local.get 5
    i32.and
    i32.add
    i32.const 1236535329
    i32.add
    i32.const 22
    i32.rotl
    local.get 3
    i32.add
    local.tee 12
    local.get 5
    i32.and
    i32.add
    i32.const 165796510
    i32.sub
    i32.const 5
    i32.rotl
    local.get 12
    i32.add
    local.tee 2
    i32.add
    local.get 3
    local.get 10
    i32.add
    local.get 2
    local.get 12
    i32.const -1
    i32.xor
    i32.and
    i32.add
    local.get 5
    local.get 22
    i32.add
    local.get 1
    local.get 12
    i32.and
    i32.add
    local.get 2
    local.get 3
    i32.and
    i32.add
    i32.const 1069501632
    i32.sub
    i32.const 9
    i32.rotl
    local.get 2
    i32.add
    local.tee 5
    local.get 12
    i32.and
    i32.add
    i32.const 643717713
    i32.add
    i32.const 14
    i32.rotl
    local.get 5
    i32.add
    local.tee 3
    local.get 5
    i32.const -1
    i32.xor
    i32.and
    i32.add
    local.get 9
    local.get 12
    i32.add
    local.get 5
    local.get 2
    i32.const -1
    i32.xor
    i32.and
    i32.add
    local.get 2
    local.get 3
    i32.and
    i32.add
    i32.const 373897302
    i32.sub
    i32.const 20
    i32.rotl
    local.get 3
    i32.add
    local.tee 2
    local.get 5
    i32.and
    i32.add
    i32.const 701558691
    i32.sub
    i32.const 5
    i32.rotl
    local.get 2
    i32.add
    local.tee 1
    i32.add
    local.get 3
    local.get 4
    i32.add
    local.get 1
    local.get 2
    i32.const -1
    i32.xor
    i32.and
    i32.add
    local.get 5
    local.get 11
    i32.add
    local.get 2
    local.get 3
    i32.const -1
    i32.xor
    i32.and
    i32.add
    local.get 1
    local.get 3
    i32.and
    i32.add
    i32.const 38016083
    i32.add
    i32.const 9
    i32.rotl
    local.get 1
    i32.add
    local.tee 5
    local.get 2
    i32.and
    i32.add
    i32.const 660478335
    i32.sub
    i32.const 14
    i32.rotl
    local.get 5
    i32.add
    local.tee 3
    local.get 5
    i32.const -1
    i32.xor
    i32.and
    i32.add
    local.get 2
    local.get 13
    i32.add
    local.get 5
    local.get 1
    i32.const -1
    i32.xor
    i32.and
    i32.add
    local.get 1
    local.get 3
    i32.and
    i32.add
    i32.const 405537848
    i32.sub
    i32.const 20
    i32.rotl
    local.get 3
    i32.add
    local.tee 2
    local.get 5
    i32.and
    i32.add
    i32.const 568446438
    i32.add
    i32.const 5
    i32.rotl
    local.get 2
    i32.add
    local.tee 1
    i32.add
    local.get 3
    local.get 19
    i32.add
    local.get 1
    local.get 2
    i32.const -1
    i32.xor
    i32.and
    i32.add
    local.get 5
    local.get 7
    i32.add
    local.get 2
    local.get 3
    i32.const -1
    i32.xor
    i32.and
    i32.add
    local.get 1
    local.get 3
    i32.and
    i32.add
    i32.const 1019803690
    i32.sub
    i32.const 9
    i32.rotl
    local.get 1
    i32.add
    local.tee 5
    local.get 2
    i32.and
    i32.add
    i32.const 187363961
    i32.sub
    i32.const 14
    i32.rotl
    local.get 5
    i32.add
    local.tee 3
    local.get 5
    i32.const -1
    i32.xor
    i32.and
    i32.add
    local.get 2
    local.get 8
    i32.add
    local.get 5
    local.get 1
    i32.const -1
    i32.xor
    i32.and
    i32.add
    local.get 1
    local.get 3
    i32.and
    i32.add
    i32.const 1163531501
    i32.add
    i32.const 20
    i32.rotl
    local.get 3
    i32.add
    local.tee 2
    local.get 5
    i32.and
    i32.add
    i32.const 1444681467
    i32.sub
    i32.const 5
    i32.rotl
    local.get 2
    i32.add
    local.tee 1
    i32.add
    local.get 2
    local.get 14
    i32.add
    local.get 5
    local.get 20
    i32.add
    local.get 2
    local.get 3
    i32.const -1
    i32.xor
    i32.and
    i32.add
    local.get 1
    local.get 3
    i32.and
    i32.add
    i32.const 51403784
    i32.sub
    i32.const 9
    i32.rotl
    local.get 1
    i32.add
    local.tee 12
    local.get 1
    i32.const -1
    i32.xor
    i32.and
    i32.add
    local.get 3
    local.get 21
    i32.add
    local.get 1
    local.get 2
    i32.const -1
    i32.xor
    i32.and
    i32.add
    local.get 2
    local.get 12
    i32.and
    i32.add
    i32.const 1735328473
    i32.add
    i32.const 14
    i32.rotl
    local.get 12
    i32.add
    local.tee 3
    local.get 1
    i32.and
    i32.add
    i32.const 1926607734
    i32.sub
    i32.const 20
    i32.rotl
    local.get 3
    i32.add
    local.tee 2
    local.get 3
    i32.xor
    local.tee 1
    local.get 12
    i32.xor
    i32.add
    i32.const 378558
    i32.sub
    i32.const 4
    i32.rotl
    local.get 2
    i32.add
    local.tee 5
    i32.add
    local.get 3
    local.get 10
    i32.add
    local.get 8
    local.get 12
    i32.add
    local.get 1
    local.get 5
    i32.xor
    i32.add
    i32.const 2022574463
    i32.sub
    i32.const 11
    i32.rotl
    local.get 5
    i32.add
    local.tee 8
    local.get 2
    local.get 5
    i32.xor
    i32.xor
    i32.add
    i32.const 1839030562
    i32.add
    i32.const 16
    i32.rotl
    local.get 8
    i32.add
    local.tee 3
    local.get 8
    i32.xor
    local.get 2
    local.get 7
    i32.add
    local.get 5
    local.get 8
    i32.xor
    local.get 3
    i32.xor
    i32.add
    i32.const 35309556
    i32.sub
    i32.const 23
    i32.rotl
    local.get 3
    i32.add
    local.tee 2
    i32.xor
    i32.add
    i32.const 1530992060
    i32.sub
    i32.const 4
    i32.rotl
    local.get 2
    i32.add
    local.tee 1
    i32.add
    local.get 3
    local.get 21
    i32.add
    local.get 8
    local.get 13
    i32.add
    local.get 2
    local.get 3
    i32.xor
    local.get 1
    i32.xor
    i32.add
    i32.const 1272893353
    i32.add
    i32.const 11
    i32.rotl
    local.get 1
    i32.add
    local.tee 8
    local.get 1
    local.get 2
    i32.xor
    i32.xor
    i32.add
    i32.const 155497632
    i32.sub
    i32.const 16
    i32.rotl
    local.get 8
    i32.add
    local.tee 3
    local.get 8
    i32.xor
    local.get 2
    local.get 11
    i32.add
    local.get 1
    local.get 8
    i32.xor
    local.get 3
    i32.xor
    i32.add
    i32.const 1094730640
    i32.sub
    i32.const 23
    i32.rotl
    local.get 3
    i32.add
    local.tee 2
    i32.xor
    i32.add
    i32.const 681279174
    i32.add
    i32.const 4
    i32.rotl
    local.get 2
    i32.add
    local.tee 1
    i32.add
    local.get 3
    local.get 19
    i32.add
    local.get 8
    local.get 9
    i32.add
    local.get 2
    local.get 3
    i32.xor
    local.get 1
    i32.xor
    i32.add
    i32.const 358537222
    i32.sub
    i32.const 11
    i32.rotl
    local.get 1
    i32.add
    local.tee 9
    local.get 1
    local.get 2
    i32.xor
    i32.xor
    i32.add
    i32.const 722521979
    i32.sub
    i32.const 16
    i32.rotl
    local.get 9
    i32.add
    local.tee 3
    local.get 9
    i32.xor
    local.get 2
    local.get 22
    i32.add
    local.get 1
    local.get 9
    i32.xor
    local.get 3
    i32.xor
    i32.add
    i32.const 76029189
    i32.add
    i32.const 23
    i32.rotl
    local.get 3
    i32.add
    local.tee 2
    i32.xor
    i32.add
    i32.const 640364487
    i32.sub
    i32.const 4
    i32.rotl
    local.get 2
    i32.add
    local.tee 1
    i32.add
    local.get 2
    local.get 20
    i32.add
    local.get 9
    local.get 14
    i32.add
    local.get 2
    local.get 3
    i32.xor
    local.get 1
    i32.xor
    i32.add
    i32.const 421815835
    i32.sub
    i32.const 11
    i32.rotl
    local.get 1
    i32.add
    local.tee 9
    local.get 1
    i32.xor
    local.get 3
    local.get 4
    i32.add
    local.get 1
    local.get 2
    i32.xor
    local.get 9
    i32.xor
    i32.add
    i32.const 530742520
    i32.add
    i32.const 16
    i32.rotl
    local.get 9
    i32.add
    local.tee 3
    i32.xor
    i32.add
    i32.const 995338651
    i32.sub
    i32.const 23
    i32.rotl
    local.get 3
    i32.add
    local.tee 2
    local.get 9
    i32.const -1
    i32.xor
    i32.or
    local.get 3
    i32.xor
    i32.add
    i32.const 198630844
    i32.sub
    i32.const 6
    i32.rotl
    local.get 2
    i32.add
    local.tee 1
    i32.add
    local.get 2
    local.get 18
    i32.add
    local.get 3
    local.get 7
    i32.add
    local.get 9
    local.get 21
    i32.add
    local.get 1
    local.get 3
    i32.const -1
    i32.xor
    i32.or
    local.get 2
    i32.xor
    i32.add
    i32.const 1126891415
    i32.add
    i32.const 10
    i32.rotl
    local.get 1
    i32.add
    local.tee 7
    local.get 2
    i32.const -1
    i32.xor
    i32.or
    local.get 1
    i32.xor
    i32.add
    i32.const 1416354905
    i32.sub
    i32.const 15
    i32.rotl
    local.get 7
    i32.add
    local.tee 3
    local.get 1
    i32.const -1
    i32.xor
    i32.or
    local.get 7
    i32.xor
    i32.add
    i32.const 57434055
    i32.sub
    i32.const 21
    i32.rotl
    local.get 3
    i32.add
    local.tee 2
    local.get 7
    i32.const -1
    i32.xor
    i32.or
    local.get 3
    i32.xor
    i32.add
    i32.const 1700485571
    i32.add
    i32.const 6
    i32.rotl
    local.get 2
    i32.add
    local.tee 1
    i32.add
    local.get 2
    local.get 17
    i32.add
    local.get 3
    local.get 11
    i32.add
    local.get 7
    local.get 19
    i32.add
    local.get 1
    local.get 3
    i32.const -1
    i32.xor
    i32.or
    local.get 2
    i32.xor
    i32.add
    i32.const 1894986606
    i32.sub
    i32.const 10
    i32.rotl
    local.get 1
    i32.add
    local.tee 7
    local.get 2
    i32.const -1
    i32.xor
    i32.or
    local.get 1
    i32.xor
    i32.add
    i32.const 1051523
    i32.sub
    i32.const 15
    i32.rotl
    local.get 7
    i32.add
    local.tee 2
    local.get 1
    i32.const -1
    i32.xor
    i32.or
    local.get 7
    i32.xor
    i32.add
    i32.const 2054922799
    i32.sub
    i32.const 21
    i32.rotl
    local.get 2
    i32.add
    local.tee 1
    local.get 7
    i32.const -1
    i32.xor
    i32.or
    local.get 2
    i32.xor
    i32.add
    i32.const 1873313359
    i32.add
    i32.const 6
    i32.rotl
    local.get 1
    i32.add
    local.tee 3
    i32.add
    local.get 1
    local.get 16
    i32.add
    local.get 2
    local.get 22
    i32.add
    local.get 4
    local.get 7
    i32.add
    local.get 3
    local.get 2
    i32.const -1
    i32.xor
    i32.or
    local.get 1
    i32.xor
    i32.add
    i32.const 30611744
    i32.sub
    i32.const 10
    i32.rotl
    local.get 3
    i32.add
    local.tee 2
    local.get 1
    i32.const -1
    i32.xor
    i32.or
    local.get 3
    i32.xor
    i32.add
    i32.const 1560198380
    i32.sub
    i32.const 15
    i32.rotl
    local.get 2
    i32.add
    local.tee 1
    local.get 3
    i32.const -1
    i32.xor
    i32.or
    local.get 2
    i32.xor
    i32.add
    i32.const 1309151649
    i32.add
    i32.const 21
    i32.rotl
    local.get 1
    i32.add
    local.tee 4
    local.get 2
    i32.const -1
    i32.xor
    i32.or
    local.get 1
    i32.xor
    i32.add
    i32.const 145523070
    i32.sub
    i32.const 6
    i32.rotl
    local.get 4
    i32.add
    local.tee 3
    local.get 0
    i32.load
    i32.add
    i32.store
    local.get 0
    local.get 2
    local.get 10
    i32.add
    local.get 3
    local.get 1
    i32.const -1
    i32.xor
    i32.or
    local.get 4
    i32.xor
    i32.add
    i32.const 1120210379
    i32.sub
    i32.const 10
    i32.rotl
    local.get 3
    i32.add
    local.tee 2
    local.get 0
    i32.load offset=12
    i32.add
    i32.store offset=12
    local.get 0
    local.get 1
    local.get 20
    i32.add
    local.get 2
    local.get 4
    i32.const -1
    i32.xor
    i32.or
    local.get 3
    i32.xor
    i32.add
    i32.const 718787259
    i32.add
    i32.const 15
    i32.rotl
    local.get 2
    i32.add
    local.tee 1
    local.get 0
    i32.load offset=8
    i32.add
    i32.store offset=8
    local.get 0
    local.get 1
    local.get 0
    i32.load offset=4
    i32.add
    local.get 4
    local.get 15
    i32.add
    local.get 1
    local.get 3
    i32.const -1
    i32.xor
    i32.or
    local.get 2
    i32.xor
    i32.add
    i32.const 343485551
    i32.sub
    i32.const 21
    i32.rotl
    i32.add
    i32.store offset=4
    local.get 6
    i32.const 256
    i32.add
    global.set 0)
  (func (;19;) (type 1) (param i32 i32 i32) (result i32)
    (local i32)
    local.get 0
    i32.load offset=20
    local.tee 3
    local.get 1
    local.get 2
    local.get 0
    i32.load offset=16
    local.get 3
    i32.sub
    local.tee 1
    local.get 1
    local.get 2
    i32.gt_u
    select
    local.tee 1
    call 7
    local.get 0
    local.get 0
    i32.load offset=20
    local.get 1
    i32.add
    i32.store offset=20
    local.get 2)
  (func (;20;) (type 0) (param i32) (result i32)
    (local i32 i32 i32 i32 i32)
    global.get 0
    i32.const 48
    i32.sub
    local.tee 3
    global.set 0
    call 0
    if  ;; label = @1
      local.get 3
      i32.const 0
      i32.const 33
      call 6
      local.tee 4
      local.set 5
      loop  ;; label = @2
        local.get 1
        i32.const 32
        i32.ne
        if  ;; label = @3
          local.get 1
          local.get 5
          i32.add
          local.get 1
          i32.const 2
          i32.shl
          i32.const 1184
          i32.add
          i32.load
          i32.store8
          local.get 1
          i32.const 1
          i32.add
          local.set 1
          br 1 (;@2;)
        end
      end
      loop  ;; label = @2
        local.get 2
        i32.const 32
        i32.eq
        if  ;; label = @3
          local.get 0
          i32.const 0
          i32.store8 offset=32
        else
          local.get 0
          local.get 2
          i32.add
          local.get 2
          local.get 4
          i32.add
          i32.load8_u
          i32.store8
          local.get 2
          i32.const 1
          i32.add
          local.set 2
          br 1 (;@2;)
        end
      end
    end
    local.get 3
    i32.const 48
    i32.add
    global.set 0
    local.get 0)
  (func (;21;) (type 1) (param i32 i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    global.get 0
    i32.const 48
    i32.sub
    local.tee 17
    global.set 0
    call 0
    if  ;; label = @1
      local.get 0
      local.set 10
      local.get 1
      local.set 12
      local.get 17
      i32.const 0
      i32.const 33
      call 6
      local.tee 20
      local.set 18
      i32.const 0
      local.set 0
      global.get 0
      i32.const 128
      i32.sub
      local.tee 13
      global.set 0
      local.get 13
      i32.const 16
      i32.add
      i32.const 0
      i32.const 100
      call 6
      drop
      local.get 13
      i32.const 16
      i32.add
      i32.const 100
      call 11
      local.get 13
      i32.const 16
      i32.add
      local.set 1
      loop  ;; label = @2
        local.get 0
        i32.const 32
        i32.ne
        if  ;; label = @3
          local.get 0
          local.get 1
          i32.add
          local.get 0
          i32.const 2
          i32.shl
          i32.const 1024
          i32.add
          i32.load
          i32.store8
          local.get 0
          i32.const 1
          i32.add
          local.set 0
          br 1 (;@2;)
        end
      end
      block (result i32)  ;; label = @2
        local.get 13
        i32.const 16
        i32.add
        call 5
        local.get 12
        call 5
        i32.add
        local.get 10
        call 5
        i32.add
        i32.const 1
        i32.add
        local.tee 21
        local.set 0
        global.get 0
        i32.const 16
        i32.sub
        local.tee 19
        global.set 0
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              block  ;; label = @6
                block  ;; label = @7
                  block  ;; label = @8
                    block  ;; label = @9
                      block  ;; label = @10
                        block  ;; label = @11
                          block  ;; label = @12
                            block  ;; label = @13
                              block  ;; label = @14
                                local.get 0
                                i32.const 244
                                i32.le_u
                                if  ;; label = @15
                                  i32.const 2632
                                  i32.load
                                  local.tee 7
                                  i32.const 16
                                  local.get 0
                                  i32.const 11
                                  i32.add
                                  i32.const -8
                                  i32.and
                                  local.get 0
                                  i32.const 11
                                  i32.lt_u
                                  select
                                  local.tee 6
                                  i32.const 3
                                  i32.shr_u
                                  local.tee 0
                                  i32.shr_u
                                  local.tee 1
                                  i32.const 3
                                  i32.and
                                  if  ;; label = @16
                                    local.get 1
                                    i32.const -1
                                    i32.xor
                                    i32.const 1
                                    i32.and
                                    local.get 0
                                    i32.add
                                    local.tee 3
                                    i32.const 3
                                    i32.shl
                                    local.tee 5
                                    i32.const 2680
                                    i32.add
                                    i32.load
                                    local.tee 1
                                    i32.const 8
                                    i32.add
                                    local.set 0
                                    block  ;; label = @17
                                      local.get 1
                                      i32.load offset=8
                                      local.tee 4
                                      local.get 5
                                      i32.const 2672
                                      i32.add
                                      local.tee 5
                                      i32.eq
                                      if  ;; label = @18
                                        i32.const 2632
                                        local.get 7
                                        i32.const -2
                                        local.get 3
                                        i32.rotl
                                        i32.and
                                        i32.store
                                        br 1 (;@17;)
                                      end
                                      local.get 4
                                      local.get 5
                                      i32.store offset=12
                                      local.get 5
                                      local.get 4
                                      i32.store offset=8
                                    end
                                    local.get 1
                                    local.get 3
                                    i32.const 3
                                    i32.shl
                                    local.tee 3
                                    i32.const 3
                                    i32.or
                                    i32.store offset=4
                                    local.get 1
                                    local.get 3
                                    i32.add
                                    local.tee 1
                                    local.get 1
                                    i32.load offset=4
                                    i32.const 1
                                    i32.or
                                    i32.store offset=4
                                    br 13 (;@3;)
                                  end
                                  local.get 6
                                  i32.const 2640
                                  i32.load
                                  local.tee 9
                                  i32.le_u
                                  br_if 1 (;@14;)
                                  local.get 1
                                  if  ;; label = @16
                                    block  ;; label = @17
                                      i32.const 2
                                      local.get 0
                                      i32.shl
                                      local.tee 3
                                      i32.const 0
                                      local.get 3
                                      i32.sub
                                      i32.or
                                      local.get 1
                                      local.get 0
                                      i32.shl
                                      i32.and
                                      local.tee 0
                                      i32.const 0
                                      local.get 0
                                      i32.sub
                                      i32.and
                                      i32.const 1
                                      i32.sub
                                      local.tee 0
                                      local.get 0
                                      i32.const 12
                                      i32.shr_u
                                      i32.const 16
                                      i32.and
                                      local.tee 0
                                      i32.shr_u
                                      local.tee 1
                                      i32.const 5
                                      i32.shr_u
                                      i32.const 8
                                      i32.and
                                      local.tee 3
                                      local.get 0
                                      i32.or
                                      local.get 1
                                      local.get 3
                                      i32.shr_u
                                      local.tee 0
                                      i32.const 2
                                      i32.shr_u
                                      i32.const 4
                                      i32.and
                                      local.tee 1
                                      i32.or
                                      local.get 0
                                      local.get 1
                                      i32.shr_u
                                      local.tee 0
                                      i32.const 1
                                      i32.shr_u
                                      i32.const 2
                                      i32.and
                                      local.tee 1
                                      i32.or
                                      local.get 0
                                      local.get 1
                                      i32.shr_u
                                      local.tee 0
                                      i32.const 1
                                      i32.shr_u
                                      i32.const 1
                                      i32.and
                                      local.tee 1
                                      i32.or
                                      local.get 0
                                      local.get 1
                                      i32.shr_u
                                      i32.add
                                      local.tee 3
                                      i32.const 3
                                      i32.shl
                                      local.tee 4
                                      i32.const 2680
                                      i32.add
                                      i32.load
                                      local.tee 1
                                      i32.load offset=8
                                      local.tee 0
                                      local.get 4
                                      i32.const 2672
                                      i32.add
                                      local.tee 4
                                      i32.eq
                                      if  ;; label = @18
                                        i32.const 2632
                                        local.get 7
                                        i32.const -2
                                        local.get 3
                                        i32.rotl
                                        i32.and
                                        local.tee 7
                                        i32.store
                                        br 1 (;@17;)
                                      end
                                      local.get 0
                                      local.get 4
                                      i32.store offset=12
                                      local.get 4
                                      local.get 0
                                      i32.store offset=8
                                    end
                                    local.get 1
                                    i32.const 8
                                    i32.add
                                    local.set 0
                                    local.get 1
                                    local.get 6
                                    i32.const 3
                                    i32.or
                                    i32.store offset=4
                                    local.get 1
                                    local.get 6
                                    i32.add
                                    local.tee 8
                                    local.get 3
                                    i32.const 3
                                    i32.shl
                                    local.tee 3
                                    local.get 6
                                    i32.sub
                                    local.tee 4
                                    i32.const 1
                                    i32.or
                                    i32.store offset=4
                                    local.get 1
                                    local.get 3
                                    i32.add
                                    local.get 4
                                    i32.store
                                    local.get 9
                                    if  ;; label = @17
                                      local.get 9
                                      i32.const 3
                                      i32.shr_u
                                      local.tee 5
                                      i32.const 3
                                      i32.shl
                                      i32.const 2672
                                      i32.add
                                      local.set 1
                                      i32.const 2652
                                      i32.load
                                      local.set 3
                                      block (result i32)  ;; label = @18
                                        local.get 7
                                        i32.const 1
                                        local.get 5
                                        i32.shl
                                        local.tee 5
                                        i32.and
                                        i32.eqz
                                        if  ;; label = @19
                                          i32.const 2632
                                          local.get 5
                                          local.get 7
                                          i32.or
                                          i32.store
                                          local.get 1
                                          br 1 (;@18;)
                                        end
                                        local.get 1
                                        i32.load offset=8
                                      end
                                      local.set 5
                                      local.get 1
                                      local.get 3
                                      i32.store offset=8
                                      local.get 5
                                      local.get 3
                                      i32.store offset=12
                                      local.get 3
                                      local.get 1
                                      i32.store offset=12
                                      local.get 3
                                      local.get 5
                                      i32.store offset=8
                                    end
                                    i32.const 2652
                                    local.get 8
                                    i32.store
                                    i32.const 2640
                                    local.get 4
                                    i32.store
                                    br 13 (;@3;)
                                  end
                                  i32.const 2636
                                  i32.load
                                  local.tee 15
                                  i32.eqz
                                  br_if 1 (;@14;)
                                  local.get 15
                                  i32.const 0
                                  local.get 15
                                  i32.sub
                                  i32.and
                                  i32.const 1
                                  i32.sub
                                  local.tee 0
                                  local.get 0
                                  i32.const 12
                                  i32.shr_u
                                  i32.const 16
                                  i32.and
                                  local.tee 0
                                  i32.shr_u
                                  local.tee 1
                                  i32.const 5
                                  i32.shr_u
                                  i32.const 8
                                  i32.and
                                  local.tee 3
                                  local.get 0
                                  i32.or
                                  local.get 1
                                  local.get 3
                                  i32.shr_u
                                  local.tee 0
                                  i32.const 2
                                  i32.shr_u
                                  i32.const 4
                                  i32.and
                                  local.tee 1
                                  i32.or
                                  local.get 0
                                  local.get 1
                                  i32.shr_u
                                  local.tee 0
                                  i32.const 1
                                  i32.shr_u
                                  i32.const 2
                                  i32.and
                                  local.tee 1
                                  i32.or
                                  local.get 0
                                  local.get 1
                                  i32.shr_u
                                  local.tee 0
                                  i32.const 1
                                  i32.shr_u
                                  i32.const 1
                                  i32.and
                                  local.tee 1
                                  i32.or
                                  local.get 0
                                  local.get 1
                                  i32.shr_u
                                  i32.add
                                  i32.const 2
                                  i32.shl
                                  i32.const 2936
                                  i32.add
                                  i32.load
                                  local.tee 1
                                  i32.load offset=4
                                  i32.const -8
                                  i32.and
                                  local.get 6
                                  i32.sub
                                  local.set 5
                                  local.get 1
                                  local.set 3
                                  loop  ;; label = @16
                                    block  ;; label = @17
                                      local.get 3
                                      i32.load offset=16
                                      local.tee 0
                                      i32.eqz
                                      if  ;; label = @18
                                        local.get 3
                                        i32.load offset=20
                                        local.tee 0
                                        i32.eqz
                                        br_if 1 (;@17;)
                                      end
                                      local.get 0
                                      i32.load offset=4
                                      i32.const -8
                                      i32.and
                                      local.get 6
                                      i32.sub
                                      local.tee 3
                                      local.get 5
                                      local.get 3
                                      local.get 5
                                      i32.lt_u
                                      local.tee 3
                                      select
                                      local.set 5
                                      local.get 0
                                      local.get 1
                                      local.get 3
                                      select
                                      local.set 1
                                      local.get 0
                                      local.set 3
                                      br 1 (;@16;)
                                    end
                                  end
                                  local.get 1
                                  local.get 6
                                  i32.add
                                  local.tee 16
                                  local.get 1
                                  i32.le_u
                                  br_if 2 (;@13;)
                                  local.get 1
                                  i32.load offset=24
                                  local.set 11
                                  local.get 1
                                  local.get 1
                                  i32.load offset=12
                                  local.tee 4
                                  i32.ne
                                  if  ;; label = @16
                                    local.get 1
                                    i32.load offset=8
                                    local.tee 0
                                    i32.const 2648
                                    i32.load
                                    i32.lt_u
                                    drop
                                    local.get 0
                                    local.get 4
                                    i32.store offset=12
                                    local.get 4
                                    local.get 0
                                    i32.store offset=8
                                    br 12 (;@4;)
                                  end
                                  local.get 1
                                  i32.const 20
                                  i32.add
                                  local.tee 3
                                  i32.load
                                  local.tee 0
                                  i32.eqz
                                  if  ;; label = @16
                                    local.get 1
                                    i32.load offset=16
                                    local.tee 0
                                    i32.eqz
                                    br_if 4 (;@12;)
                                    local.get 1
                                    i32.const 16
                                    i32.add
                                    local.set 3
                                  end
                                  loop  ;; label = @16
                                    local.get 3
                                    local.set 8
                                    local.get 0
                                    local.tee 4
                                    i32.const 20
                                    i32.add
                                    local.tee 3
                                    i32.load
                                    local.tee 0
                                    br_if 0 (;@16;)
                                    local.get 4
                                    i32.const 16
                                    i32.add
                                    local.set 3
                                    local.get 4
                                    i32.load offset=16
                                    local.tee 0
                                    br_if 0 (;@16;)
                                  end
                                  local.get 8
                                  i32.const 0
                                  i32.store
                                  br 11 (;@4;)
                                end
                                i32.const -1
                                local.set 6
                                local.get 0
                                i32.const -65
                                i32.gt_u
                                br_if 0 (;@14;)
                                local.get 0
                                i32.const 11
                                i32.add
                                local.tee 0
                                i32.const -8
                                i32.and
                                local.set 6
                                i32.const 2636
                                i32.load
                                local.tee 9
                                i32.eqz
                                br_if 0 (;@14;)
                                i32.const 0
                                local.get 6
                                i32.sub
                                local.set 5
                                block  ;; label = @15
                                  block  ;; label = @16
                                    block  ;; label = @17
                                      block (result i32)  ;; label = @18
                                        i32.const 0
                                        local.get 6
                                        i32.const 256
                                        i32.lt_u
                                        br_if 0 (;@18;)
                                        drop
                                        i32.const 31
                                        local.get 6
                                        i32.const 16777215
                                        i32.gt_u
                                        br_if 0 (;@18;)
                                        drop
                                        local.get 0
                                        i32.const 8
                                        i32.shr_u
                                        local.tee 0
                                        local.get 0
                                        i32.const 1048320
                                        i32.add
                                        i32.const 16
                                        i32.shr_u
                                        i32.const 8
                                        i32.and
                                        local.tee 0
                                        i32.shl
                                        local.tee 1
                                        local.get 1
                                        i32.const 520192
                                        i32.add
                                        i32.const 16
                                        i32.shr_u
                                        i32.const 4
                                        i32.and
                                        local.tee 1
                                        i32.shl
                                        local.tee 3
                                        local.get 3
                                        i32.const 245760
                                        i32.add
                                        i32.const 16
                                        i32.shr_u
                                        i32.const 2
                                        i32.and
                                        local.tee 3
                                        i32.shl
                                        i32.const 15
                                        i32.shr_u
                                        local.get 0
                                        local.get 1
                                        i32.or
                                        local.get 3
                                        i32.or
                                        i32.sub
                                        local.tee 0
                                        i32.const 1
                                        i32.shl
                                        local.get 6
                                        local.get 0
                                        i32.const 21
                                        i32.add
                                        i32.shr_u
                                        i32.const 1
                                        i32.and
                                        i32.or
                                        i32.const 28
                                        i32.add
                                      end
                                      local.tee 8
                                      i32.const 2
                                      i32.shl
                                      i32.const 2936
                                      i32.add
                                      i32.load
                                      local.tee 3
                                      i32.eqz
                                      if  ;; label = @18
                                        i32.const 0
                                        local.set 0
                                        br 1 (;@17;)
                                      end
                                      i32.const 0
                                      local.set 0
                                      local.get 6
                                      i32.const 0
                                      i32.const 25
                                      local.get 8
                                      i32.const 1
                                      i32.shr_u
                                      i32.sub
                                      local.get 8
                                      i32.const 31
                                      i32.eq
                                      select
                                      i32.shl
                                      local.set 1
                                      loop  ;; label = @18
                                        block  ;; label = @19
                                          local.get 3
                                          i32.load offset=4
                                          i32.const -8
                                          i32.and
                                          local.get 6
                                          i32.sub
                                          local.tee 7
                                          local.get 5
                                          i32.ge_u
                                          br_if 0 (;@19;)
                                          local.get 3
                                          local.set 4
                                          local.get 7
                                          local.tee 5
                                          br_if 0 (;@19;)
                                          i32.const 0
                                          local.set 5
                                          local.get 3
                                          local.set 0
                                          br 3 (;@16;)
                                        end
                                        local.get 0
                                        local.get 3
                                        i32.load offset=20
                                        local.tee 7
                                        local.get 7
                                        local.get 3
                                        local.get 1
                                        i32.const 29
                                        i32.shr_u
                                        i32.const 4
                                        i32.and
                                        i32.add
                                        i32.load offset=16
                                        local.tee 3
                                        i32.eq
                                        select
                                        local.get 0
                                        local.get 7
                                        select
                                        local.set 0
                                        local.get 1
                                        i32.const 1
                                        i32.shl
                                        local.set 1
                                        local.get 3
                                        br_if 0 (;@18;)
                                      end
                                    end
                                    local.get 0
                                    local.get 4
                                    i32.or
                                    i32.eqz
                                    if  ;; label = @17
                                      i32.const 0
                                      local.set 4
                                      i32.const 2
                                      local.get 8
                                      i32.shl
                                      local.tee 0
                                      i32.const 0
                                      local.get 0
                                      i32.sub
                                      i32.or
                                      local.get 9
                                      i32.and
                                      local.tee 0
                                      i32.eqz
                                      br_if 3 (;@14;)
                                      local.get 0
                                      i32.const 0
                                      local.get 0
                                      i32.sub
                                      i32.and
                                      i32.const 1
                                      i32.sub
                                      local.tee 0
                                      local.get 0
                                      i32.const 12
                                      i32.shr_u
                                      i32.const 16
                                      i32.and
                                      local.tee 0
                                      i32.shr_u
                                      local.tee 1
                                      i32.const 5
                                      i32.shr_u
                                      i32.const 8
                                      i32.and
                                      local.tee 3
                                      local.get 0
                                      i32.or
                                      local.get 1
                                      local.get 3
                                      i32.shr_u
                                      local.tee 0
                                      i32.const 2
                                      i32.shr_u
                                      i32.const 4
                                      i32.and
                                      local.tee 1
                                      i32.or
                                      local.get 0
                                      local.get 1
                                      i32.shr_u
                                      local.tee 0
                                      i32.const 1
                                      i32.shr_u
                                      i32.const 2
                                      i32.and
                                      local.tee 1
                                      i32.or
                                      local.get 0
                                      local.get 1
                                      i32.shr_u
                                      local.tee 0
                                      i32.const 1
                                      i32.shr_u
                                      i32.const 1
                                      i32.and
                                      local.tee 1
                                      i32.or
                                      local.get 0
                                      local.get 1
                                      i32.shr_u
                                      i32.add
                                      i32.const 2
                                      i32.shl
                                      i32.const 2936
                                      i32.add
                                      i32.load
                                      local.set 0
                                    end
                                    local.get 0
                                    i32.eqz
                                    br_if 1 (;@15;)
                                  end
                                  loop  ;; label = @16
                                    local.get 0
                                    i32.load offset=4
                                    i32.const -8
                                    i32.and
                                    local.get 6
                                    i32.sub
                                    local.tee 3
                                    local.get 5
                                    i32.lt_u
                                    local.set 1
                                    local.get 3
                                    local.get 5
                                    local.get 1
                                    select
                                    local.set 5
                                    local.get 0
                                    local.get 4
                                    local.get 1
                                    select
                                    local.set 4
                                    local.get 0
                                    i32.load offset=16
                                    local.tee 1
                                    if (result i32)  ;; label = @17
                                      local.get 1
                                    else
                                      local.get 0
                                      i32.load offset=20
                                    end
                                    local.tee 0
                                    br_if 0 (;@16;)
                                  end
                                end
                                local.get 4
                                i32.eqz
                                br_if 0 (;@14;)
                                local.get 5
                                i32.const 2640
                                i32.load
                                local.get 6
                                i32.sub
                                i32.ge_u
                                br_if 0 (;@14;)
                                local.get 4
                                local.get 6
                                i32.add
                                local.tee 8
                                local.get 4
                                i32.le_u
                                br_if 1 (;@13;)
                                local.get 4
                                i32.load offset=24
                                local.set 11
                                local.get 4
                                local.get 4
                                i32.load offset=12
                                local.tee 1
                                i32.ne
                                if  ;; label = @15
                                  local.get 4
                                  i32.load offset=8
                                  local.tee 0
                                  i32.const 2648
                                  i32.load
                                  i32.lt_u
                                  drop
                                  local.get 0
                                  local.get 1
                                  i32.store offset=12
                                  local.get 1
                                  local.get 0
                                  i32.store offset=8
                                  br 10 (;@5;)
                                end
                                local.get 4
                                i32.const 20
                                i32.add
                                local.tee 3
                                i32.load
                                local.tee 0
                                i32.eqz
                                if  ;; label = @15
                                  local.get 4
                                  i32.load offset=16
                                  local.tee 0
                                  i32.eqz
                                  br_if 4 (;@11;)
                                  local.get 4
                                  i32.const 16
                                  i32.add
                                  local.set 3
                                end
                                loop  ;; label = @15
                                  local.get 3
                                  local.set 7
                                  local.get 0
                                  local.tee 1
                                  i32.const 20
                                  i32.add
                                  local.tee 3
                                  i32.load
                                  local.tee 0
                                  br_if 0 (;@15;)
                                  local.get 1
                                  i32.const 16
                                  i32.add
                                  local.set 3
                                  local.get 1
                                  i32.load offset=16
                                  local.tee 0
                                  br_if 0 (;@15;)
                                end
                                local.get 7
                                i32.const 0
                                i32.store
                                br 9 (;@5;)
                              end
                              local.get 6
                              i32.const 2640
                              i32.load
                              local.tee 1
                              i32.le_u
                              if  ;; label = @14
                                i32.const 2652
                                i32.load
                                local.set 0
                                block  ;; label = @15
                                  local.get 1
                                  local.get 6
                                  i32.sub
                                  local.tee 3
                                  i32.const 16
                                  i32.ge_u
                                  if  ;; label = @16
                                    i32.const 2640
                                    local.get 3
                                    i32.store
                                    i32.const 2652
                                    local.get 0
                                    local.get 6
                                    i32.add
                                    local.tee 4
                                    i32.store
                                    local.get 4
                                    local.get 3
                                    i32.const 1
                                    i32.or
                                    i32.store offset=4
                                    local.get 0
                                    local.get 1
                                    i32.add
                                    local.get 3
                                    i32.store
                                    local.get 0
                                    local.get 6
                                    i32.const 3
                                    i32.or
                                    i32.store offset=4
                                    br 1 (;@15;)
                                  end
                                  i32.const 2652
                                  i32.const 0
                                  i32.store
                                  i32.const 2640
                                  i32.const 0
                                  i32.store
                                  local.get 0
                                  local.get 1
                                  i32.const 3
                                  i32.or
                                  i32.store offset=4
                                  local.get 0
                                  local.get 1
                                  i32.add
                                  local.tee 1
                                  local.get 1
                                  i32.load offset=4
                                  i32.const 1
                                  i32.or
                                  i32.store offset=4
                                end
                                local.get 0
                                i32.const 8
                                i32.add
                                local.set 0
                                br 11 (;@3;)
                              end
                              local.get 6
                              i32.const 2644
                              i32.load
                              local.tee 1
                              i32.lt_u
                              if  ;; label = @14
                                i32.const 2644
                                local.get 1
                                local.get 6
                                i32.sub
                                local.tee 1
                                i32.store
                                i32.const 2656
                                i32.const 2656
                                i32.load
                                local.tee 0
                                local.get 6
                                i32.add
                                local.tee 3
                                i32.store
                                local.get 3
                                local.get 1
                                i32.const 1
                                i32.or
                                i32.store offset=4
                                local.get 0
                                local.get 6
                                i32.const 3
                                i32.or
                                i32.store offset=4
                                local.get 0
                                i32.const 8
                                i32.add
                                local.set 0
                                br 11 (;@3;)
                              end
                              i32.const 0
                              local.set 0
                              local.get 6
                              i32.const 47
                              i32.add
                              local.tee 5
                              block (result i32)  ;; label = @14
                                i32.const 3104
                                i32.load
                                if  ;; label = @15
                                  i32.const 3112
                                  i32.load
                                  br 1 (;@14;)
                                end
                                i32.const 3116
                                i64.const -1
                                i64.store align=4
                                i32.const 3108
                                i64.const 17592186048512
                                i64.store align=4
                                i32.const 3104
                                local.get 19
                                i32.const 12
                                i32.add
                                i32.const -16
                                i32.and
                                i32.const 1431655768
                                i32.xor
                                i32.store
                                i32.const 3124
                                i32.const 0
                                i32.store
                                i32.const 3076
                                i32.const 0
                                i32.store
                                i32.const 4096
                              end
                              local.tee 3
                              i32.add
                              local.tee 7
                              i32.const 0
                              local.get 3
                              i32.sub
                              local.tee 8
                              i32.and
                              local.tee 3
                              local.get 6
                              i32.le_u
                              br_if 10 (;@3;)
                              i32.const 3072
                              i32.load
                              local.tee 4
                              if  ;; label = @14
                                i32.const 3064
                                i32.load
                                local.tee 9
                                local.get 3
                                i32.add
                                local.tee 11
                                local.get 9
                                i32.le_u
                                local.get 4
                                local.get 11
                                i32.lt_u
                                i32.or
                                br_if 11 (;@3;)
                              end
                              i32.const 3076
                              i32.load8_u
                              i32.const 4
                              i32.and
                              br_if 5 (;@8;)
                              block  ;; label = @14
                                block  ;; label = @15
                                  i32.const 2656
                                  i32.load
                                  local.tee 4
                                  if  ;; label = @16
                                    i32.const 3080
                                    local.set 0
                                    loop  ;; label = @17
                                      local.get 4
                                      local.get 0
                                      i32.load
                                      local.tee 9
                                      i32.ge_u
                                      if  ;; label = @18
                                        local.get 9
                                        local.get 0
                                        i32.load offset=4
                                        i32.add
                                        local.get 4
                                        i32.gt_u
                                        br_if 3 (;@15;)
                                      end
                                      local.get 0
                                      i32.load offset=8
                                      local.tee 0
                                      br_if 0 (;@17;)
                                    end
                                  end
                                  i32.const 0
                                  call 2
                                  local.tee 1
                                  i32.const -1
                                  i32.eq
                                  br_if 6 (;@9;)
                                  local.get 3
                                  local.set 7
                                  i32.const 3108
                                  i32.load
                                  local.tee 0
                                  i32.const 1
                                  i32.sub
                                  local.tee 4
                                  local.get 1
                                  i32.and
                                  if  ;; label = @16
                                    local.get 3
                                    local.get 1
                                    i32.sub
                                    local.get 1
                                    local.get 4
                                    i32.add
                                    i32.const 0
                                    local.get 0
                                    i32.sub
                                    i32.and
                                    i32.add
                                    local.set 7
                                  end
                                  local.get 7
                                  i32.const 2147483646
                                  i32.gt_u
                                  local.get 6
                                  local.get 7
                                  i32.ge_u
                                  i32.or
                                  br_if 6 (;@9;)
                                  i32.const 3072
                                  i32.load
                                  local.tee 0
                                  if  ;; label = @16
                                    i32.const 3064
                                    i32.load
                                    local.tee 4
                                    local.get 7
                                    i32.add
                                    local.tee 8
                                    local.get 4
                                    i32.le_u
                                    local.get 0
                                    local.get 8
                                    i32.lt_u
                                    i32.or
                                    br_if 7 (;@9;)
                                  end
                                  local.get 7
                                  call 2
                                  local.tee 0
                                  local.get 1
                                  i32.ne
                                  br_if 1 (;@14;)
                                  br 8 (;@7;)
                                end
                                local.get 7
                                local.get 1
                                i32.sub
                                local.get 8
                                i32.and
                                local.tee 7
                                i32.const 2147483646
                                i32.gt_u
                                br_if 5 (;@9;)
                                local.get 7
                                call 2
                                local.tee 1
                                local.get 0
                                i32.load
                                local.get 0
                                i32.load offset=4
                                i32.add
                                i32.eq
                                br_if 4 (;@10;)
                                local.get 1
                                local.set 0
                              end
                              local.get 0
                              i32.const -1
                              i32.eq
                              local.get 6
                              i32.const 48
                              i32.add
                              local.get 7
                              i32.le_u
                              i32.or
                              i32.eqz
                              if  ;; label = @14
                                i32.const 3112
                                i32.load
                                local.tee 1
                                local.get 5
                                local.get 7
                                i32.sub
                                i32.add
                                i32.const 0
                                local.get 1
                                i32.sub
                                i32.and
                                local.tee 1
                                i32.const 2147483646
                                i32.gt_u
                                if  ;; label = @15
                                  local.get 0
                                  local.set 1
                                  br 8 (;@7;)
                                end
                                local.get 1
                                call 2
                                i32.const -1
                                i32.ne
                                if  ;; label = @15
                                  local.get 1
                                  local.get 7
                                  i32.add
                                  local.set 7
                                  local.get 0
                                  local.set 1
                                  br 8 (;@7;)
                                end
                                i32.const 0
                                local.get 7
                                i32.sub
                                call 2
                                drop
                                br 5 (;@9;)
                              end
                              local.get 0
                              local.tee 1
                              i32.const -1
                              i32.ne
                              br_if 6 (;@7;)
                              br 4 (;@9;)
                            end
                            unreachable
                          end
                          i32.const 0
                          local.set 4
                          br 7 (;@4;)
                        end
                        i32.const 0
                        local.set 1
                        br 5 (;@5;)
                      end
                      local.get 1
                      i32.const -1
                      i32.ne
                      br_if 2 (;@7;)
                    end
                    i32.const 3076
                    i32.const 3076
                    i32.load
                    i32.const 4
                    i32.or
                    i32.store
                  end
                  local.get 3
                  i32.const 2147483646
                  i32.gt_u
                  br_if 1 (;@6;)
                  local.get 3
                  call 2
                  local.tee 1
                  i32.const -1
                  i32.eq
                  i32.const 0
                  call 2
                  local.tee 0
                  i32.const -1
                  i32.eq
                  i32.or
                  local.get 0
                  local.get 1
                  i32.le_u
                  i32.or
                  br_if 1 (;@6;)
                  local.get 0
                  local.get 1
                  i32.sub
                  local.tee 7
                  local.get 6
                  i32.const 40
                  i32.add
                  i32.le_u
                  br_if 1 (;@6;)
                end
                i32.const 3064
                i32.const 3064
                i32.load
                local.get 7
                i32.add
                local.tee 0
                i32.store
                i32.const 3068
                i32.load
                local.get 0
                i32.lt_u
                if  ;; label = @7
                  i32.const 3068
                  local.get 0
                  i32.store
                end
                block  ;; label = @7
                  block  ;; label = @8
                    block  ;; label = @9
                      i32.const 2656
                      i32.load
                      local.tee 4
                      if  ;; label = @10
                        i32.const 3080
                        local.set 0
                        loop  ;; label = @11
                          local.get 1
                          local.get 0
                          i32.load
                          local.tee 3
                          local.get 0
                          i32.load offset=4
                          local.tee 5
                          i32.add
                          i32.eq
                          br_if 2 (;@9;)
                          local.get 0
                          i32.load offset=8
                          local.tee 0
                          br_if 0 (;@11;)
                        end
                        br 2 (;@8;)
                      end
                      i32.const 2648
                      i32.load
                      local.tee 0
                      i32.const 0
                      local.get 0
                      local.get 1
                      i32.le_u
                      select
                      i32.eqz
                      if  ;; label = @10
                        i32.const 2648
                        local.get 1
                        i32.store
                      end
                      i32.const 0
                      local.set 0
                      i32.const 3084
                      local.get 7
                      i32.store
                      i32.const 3080
                      local.get 1
                      i32.store
                      i32.const 2664
                      i32.const -1
                      i32.store
                      i32.const 2668
                      i32.const 3104
                      i32.load
                      i32.store
                      i32.const 3092
                      i32.const 0
                      i32.store
                      loop  ;; label = @10
                        local.get 0
                        i32.const 3
                        i32.shl
                        local.tee 3
                        i32.const 2680
                        i32.add
                        local.get 3
                        i32.const 2672
                        i32.add
                        local.tee 4
                        i32.store
                        local.get 3
                        i32.const 2684
                        i32.add
                        local.get 4
                        i32.store
                        local.get 0
                        i32.const 1
                        i32.add
                        local.tee 0
                        i32.const 32
                        i32.ne
                        br_if 0 (;@10;)
                      end
                      i32.const 2644
                      local.get 7
                      i32.const 40
                      i32.sub
                      local.tee 0
                      i32.const -8
                      local.get 1
                      i32.sub
                      i32.const 7
                      i32.and
                      i32.const 0
                      local.get 1
                      i32.const 8
                      i32.add
                      i32.const 7
                      i32.and
                      select
                      local.tee 3
                      i32.sub
                      local.tee 4
                      i32.store
                      i32.const 2656
                      local.get 1
                      local.get 3
                      i32.add
                      local.tee 3
                      i32.store
                      local.get 3
                      local.get 4
                      i32.const 1
                      i32.or
                      i32.store offset=4
                      local.get 0
                      local.get 1
                      i32.add
                      i32.const 40
                      i32.store offset=4
                      i32.const 2660
                      i32.const 3120
                      i32.load
                      i32.store
                      br 2 (;@7;)
                    end
                    local.get 0
                    i32.load8_u offset=12
                    i32.const 8
                    i32.and
                    local.get 3
                    local.get 4
                    i32.gt_u
                    i32.or
                    local.get 1
                    local.get 4
                    i32.le_u
                    i32.or
                    br_if 0 (;@8;)
                    local.get 0
                    local.get 5
                    local.get 7
                    i32.add
                    i32.store offset=4
                    i32.const 2656
                    local.get 4
                    i32.const -8
                    local.get 4
                    i32.sub
                    i32.const 7
                    i32.and
                    i32.const 0
                    local.get 4
                    i32.const 8
                    i32.add
                    i32.const 7
                    i32.and
                    select
                    local.tee 0
                    i32.add
                    local.tee 1
                    i32.store
                    i32.const 2644
                    i32.const 2644
                    i32.load
                    local.get 7
                    i32.add
                    local.tee 3
                    local.get 0
                    i32.sub
                    local.tee 0
                    i32.store
                    local.get 1
                    local.get 0
                    i32.const 1
                    i32.or
                    i32.store offset=4
                    local.get 3
                    local.get 4
                    i32.add
                    i32.const 40
                    i32.store offset=4
                    i32.const 2660
                    i32.const 3120
                    i32.load
                    i32.store
                    br 1 (;@7;)
                  end
                  i32.const 2648
                  i32.load
                  local.get 1
                  i32.gt_u
                  if  ;; label = @8
                    i32.const 2648
                    local.get 1
                    i32.store
                  end
                  local.get 1
                  local.get 7
                  i32.add
                  local.set 3
                  i32.const 3080
                  local.set 0
                  block  ;; label = @8
                    block  ;; label = @9
                      block  ;; label = @10
                        block  ;; label = @11
                          block  ;; label = @12
                            block  ;; label = @13
                              loop  ;; label = @14
                                local.get 3
                                local.get 0
                                i32.load
                                i32.ne
                                if  ;; label = @15
                                  local.get 0
                                  i32.load offset=8
                                  local.tee 0
                                  br_if 1 (;@14;)
                                  br 2 (;@13;)
                                end
                              end
                              local.get 0
                              i32.load8_u offset=12
                              i32.const 8
                              i32.and
                              i32.eqz
                              br_if 1 (;@12;)
                            end
                            i32.const 3080
                            local.set 0
                            loop  ;; label = @13
                              local.get 4
                              local.get 0
                              i32.load
                              local.tee 3
                              i32.ge_u
                              if  ;; label = @14
                                local.get 3
                                local.get 0
                                i32.load offset=4
                                i32.add
                                local.tee 5
                                local.get 4
                                i32.gt_u
                                br_if 3 (;@11;)
                              end
                              local.get 0
                              i32.load offset=8
                              local.set 0
                              br 0 (;@13;)
                            end
                            unreachable
                          end
                          local.get 0
                          local.get 1
                          i32.store
                          local.get 0
                          local.get 0
                          i32.load offset=4
                          local.get 7
                          i32.add
                          i32.store offset=4
                          local.get 1
                          i32.const -8
                          local.get 1
                          i32.sub
                          i32.const 7
                          i32.and
                          i32.const 0
                          local.get 1
                          i32.const 8
                          i32.add
                          i32.const 7
                          i32.and
                          select
                          i32.add
                          local.tee 9
                          local.get 6
                          i32.const 3
                          i32.or
                          i32.store offset=4
                          local.get 3
                          i32.const -8
                          local.get 3
                          i32.sub
                          i32.const 7
                          i32.and
                          i32.const 0
                          local.get 3
                          i32.const 8
                          i32.add
                          i32.const 7
                          i32.and
                          select
                          i32.add
                          local.tee 7
                          local.get 6
                          local.get 9
                          i32.add
                          local.tee 6
                          i32.sub
                          local.set 3
                          local.get 4
                          local.get 7
                          i32.eq
                          if  ;; label = @12
                            i32.const 2656
                            local.get 6
                            i32.store
                            i32.const 2644
                            i32.const 2644
                            i32.load
                            local.get 3
                            i32.add
                            local.tee 0
                            i32.store
                            local.get 6
                            local.get 0
                            i32.const 1
                            i32.or
                            i32.store offset=4
                            br 3 (;@9;)
                          end
                          local.get 7
                          i32.const 2652
                          i32.load
                          i32.eq
                          if  ;; label = @12
                            i32.const 2652
                            local.get 6
                            i32.store
                            i32.const 2640
                            i32.const 2640
                            i32.load
                            local.get 3
                            i32.add
                            local.tee 0
                            i32.store
                            local.get 6
                            local.get 0
                            i32.const 1
                            i32.or
                            i32.store offset=4
                            local.get 0
                            local.get 6
                            i32.add
                            local.get 0
                            i32.store
                            br 3 (;@9;)
                          end
                          local.get 7
                          i32.load offset=4
                          local.tee 0
                          i32.const 3
                          i32.and
                          i32.const 1
                          i32.eq
                          if  ;; label = @12
                            local.get 0
                            i32.const -8
                            i32.and
                            local.set 11
                            block  ;; label = @13
                              local.get 0
                              i32.const 255
                              i32.le_u
                              if  ;; label = @14
                                local.get 7
                                i32.load offset=8
                                local.tee 1
                                local.get 0
                                i32.const 3
                                i32.shr_u
                                local.tee 4
                                i32.const 3
                                i32.shl
                                i32.const 2672
                                i32.add
                                i32.eq
                                drop
                                local.get 1
                                local.get 7
                                i32.load offset=12
                                local.tee 0
                                i32.eq
                                if  ;; label = @15
                                  i32.const 2632
                                  i32.const 2632
                                  i32.load
                                  i32.const -2
                                  local.get 4
                                  i32.rotl
                                  i32.and
                                  i32.store
                                  br 2 (;@13;)
                                end
                                local.get 1
                                local.get 0
                                i32.store offset=12
                                local.get 0
                                local.get 1
                                i32.store offset=8
                                br 1 (;@13;)
                              end
                              local.get 7
                              i32.load offset=24
                              local.set 8
                              block  ;; label = @14
                                local.get 7
                                local.get 7
                                i32.load offset=12
                                local.tee 1
                                i32.ne
                                if  ;; label = @15
                                  local.get 7
                                  i32.load offset=8
                                  local.tee 0
                                  local.get 1
                                  i32.store offset=12
                                  local.get 1
                                  local.get 0
                                  i32.store offset=8
                                  br 1 (;@14;)
                                end
                                block  ;; label = @15
                                  local.get 7
                                  i32.const 20
                                  i32.add
                                  local.tee 0
                                  i32.load
                                  local.tee 5
                                  br_if 0 (;@15;)
                                  local.get 7
                                  i32.const 16
                                  i32.add
                                  local.tee 0
                                  i32.load
                                  local.tee 5
                                  br_if 0 (;@15;)
                                  i32.const 0
                                  local.set 1
                                  br 1 (;@14;)
                                end
                                loop  ;; label = @15
                                  local.get 0
                                  local.set 4
                                  local.get 5
                                  local.tee 1
                                  i32.const 20
                                  i32.add
                                  local.tee 0
                                  i32.load
                                  local.tee 5
                                  br_if 0 (;@15;)
                                  local.get 1
                                  i32.const 16
                                  i32.add
                                  local.set 0
                                  local.get 1
                                  i32.load offset=16
                                  local.tee 5
                                  br_if 0 (;@15;)
                                end
                                local.get 4
                                i32.const 0
                                i32.store
                              end
                              local.get 8
                              i32.eqz
                              br_if 0 (;@13;)
                              block  ;; label = @14
                                local.get 7
                                local.get 7
                                i32.load offset=28
                                local.tee 0
                                i32.const 2
                                i32.shl
                                i32.const 2936
                                i32.add
                                local.tee 4
                                i32.load
                                i32.eq
                                if  ;; label = @15
                                  local.get 4
                                  local.get 1
                                  i32.store
                                  local.get 1
                                  br_if 1 (;@14;)
                                  i32.const 2636
                                  i32.const 2636
                                  i32.load
                                  i32.const -2
                                  local.get 0
                                  i32.rotl
                                  i32.and
                                  i32.store
                                  br 2 (;@13;)
                                end
                                local.get 8
                                i32.const 16
                                i32.const 20
                                local.get 8
                                i32.load offset=16
                                local.get 7
                                i32.eq
                                select
                                i32.add
                                local.get 1
                                i32.store
                                local.get 1
                                i32.eqz
                                br_if 1 (;@13;)
                              end
                              local.get 1
                              local.get 8
                              i32.store offset=24
                              local.get 7
                              i32.load offset=16
                              local.tee 0
                              if  ;; label = @14
                                local.get 1
                                local.get 0
                                i32.store offset=16
                                local.get 0
                                local.get 1
                                i32.store offset=24
                              end
                              local.get 7
                              i32.load offset=20
                              local.tee 0
                              i32.eqz
                              br_if 0 (;@13;)
                              local.get 1
                              local.get 0
                              i32.store offset=20
                              local.get 0
                              local.get 1
                              i32.store offset=24
                            end
                            local.get 7
                            local.get 11
                            i32.add
                            local.set 7
                            local.get 3
                            local.get 11
                            i32.add
                            local.set 3
                          end
                          local.get 7
                          local.get 7
                          i32.load offset=4
                          i32.const -2
                          i32.and
                          i32.store offset=4
                          local.get 6
                          local.get 3
                          i32.const 1
                          i32.or
                          i32.store offset=4
                          local.get 3
                          local.get 6
                          i32.add
                          local.get 3
                          i32.store
                          local.get 3
                          i32.const 255
                          i32.le_u
                          if  ;; label = @12
                            local.get 3
                            i32.const 3
                            i32.shr_u
                            local.tee 1
                            i32.const 3
                            i32.shl
                            i32.const 2672
                            i32.add
                            local.set 0
                            block (result i32)  ;; label = @13
                              i32.const 2632
                              i32.load
                              local.tee 3
                              i32.const 1
                              local.get 1
                              i32.shl
                              local.tee 1
                              i32.and
                              i32.eqz
                              if  ;; label = @14
                                i32.const 2632
                                local.get 1
                                local.get 3
                                i32.or
                                i32.store
                                local.get 0
                                br 1 (;@13;)
                              end
                              local.get 0
                              i32.load offset=8
                            end
                            local.set 1
                            local.get 0
                            local.get 6
                            i32.store offset=8
                            local.get 1
                            local.get 6
                            i32.store offset=12
                            local.get 6
                            local.get 0
                            i32.store offset=12
                            local.get 6
                            local.get 1
                            i32.store offset=8
                            br 3 (;@9;)
                          end
                          i32.const 31
                          local.set 0
                          local.get 3
                          i32.const 16777215
                          i32.le_u
                          if  ;; label = @12
                            local.get 3
                            i32.const 8
                            i32.shr_u
                            local.tee 0
                            local.get 0
                            i32.const 1048320
                            i32.add
                            i32.const 16
                            i32.shr_u
                            i32.const 8
                            i32.and
                            local.tee 0
                            i32.shl
                            local.tee 1
                            local.get 1
                            i32.const 520192
                            i32.add
                            i32.const 16
                            i32.shr_u
                            i32.const 4
                            i32.and
                            local.tee 1
                            i32.shl
                            local.tee 4
                            local.get 4
                            i32.const 245760
                            i32.add
                            i32.const 16
                            i32.shr_u
                            i32.const 2
                            i32.and
                            local.tee 4
                            i32.shl
                            i32.const 15
                            i32.shr_u
                            local.get 0
                            local.get 1
                            i32.or
                            local.get 4
                            i32.or
                            i32.sub
                            local.tee 0
                            i32.const 1
                            i32.shl
                            local.get 3
                            local.get 0
                            i32.const 21
                            i32.add
                            i32.shr_u
                            i32.const 1
                            i32.and
                            i32.or
                            i32.const 28
                            i32.add
                            local.set 0
                          end
                          local.get 6
                          local.get 0
                          i32.store offset=28
                          local.get 6
                          i64.const 0
                          i64.store offset=16 align=4
                          local.get 0
                          i32.const 2
                          i32.shl
                          i32.const 2936
                          i32.add
                          local.set 1
                          block  ;; label = @12
                            i32.const 2636
                            i32.load
                            local.tee 4
                            i32.const 1
                            local.get 0
                            i32.shl
                            local.tee 5
                            i32.and
                            i32.eqz
                            if  ;; label = @13
                              i32.const 2636
                              local.get 4
                              local.get 5
                              i32.or
                              i32.store
                              local.get 1
                              local.get 6
                              i32.store
                              local.get 6
                              local.get 1
                              i32.store offset=24
                              br 1 (;@12;)
                            end
                            local.get 3
                            i32.const 0
                            i32.const 25
                            local.get 0
                            i32.const 1
                            i32.shr_u
                            i32.sub
                            local.get 0
                            i32.const 31
                            i32.eq
                            select
                            i32.shl
                            local.set 0
                            local.get 1
                            i32.load
                            local.set 1
                            loop  ;; label = @13
                              local.get 1
                              local.tee 4
                              i32.load offset=4
                              i32.const -8
                              i32.and
                              local.get 3
                              i32.eq
                              br_if 3 (;@10;)
                              local.get 0
                              i32.const 29
                              i32.shr_u
                              local.set 1
                              local.get 0
                              i32.const 1
                              i32.shl
                              local.set 0
                              local.get 4
                              local.get 1
                              i32.const 4
                              i32.and
                              i32.add
                              local.tee 5
                              i32.load offset=16
                              local.tee 1
                              br_if 0 (;@13;)
                            end
                            local.get 5
                            local.get 6
                            i32.store offset=16
                            local.get 6
                            local.get 4
                            i32.store offset=24
                          end
                          local.get 6
                          local.get 6
                          i32.store offset=12
                          local.get 6
                          local.get 6
                          i32.store offset=8
                          br 2 (;@9;)
                        end
                        i32.const 2644
                        local.get 7
                        i32.const 40
                        i32.sub
                        local.tee 0
                        i32.const -8
                        local.get 1
                        i32.sub
                        i32.const 7
                        i32.and
                        i32.const 0
                        local.get 1
                        i32.const 8
                        i32.add
                        i32.const 7
                        i32.and
                        select
                        local.tee 3
                        i32.sub
                        local.tee 8
                        i32.store
                        i32.const 2656
                        local.get 1
                        local.get 3
                        i32.add
                        local.tee 3
                        i32.store
                        local.get 3
                        local.get 8
                        i32.const 1
                        i32.or
                        i32.store offset=4
                        local.get 0
                        local.get 1
                        i32.add
                        i32.const 40
                        i32.store offset=4
                        i32.const 2660
                        i32.const 3120
                        i32.load
                        i32.store
                        local.get 4
                        local.get 5
                        i32.const 39
                        local.get 5
                        i32.sub
                        i32.const 7
                        i32.and
                        i32.const 0
                        local.get 5
                        i32.const 39
                        i32.sub
                        i32.const 7
                        i32.and
                        select
                        i32.add
                        i32.const 47
                        i32.sub
                        local.tee 0
                        local.get 0
                        local.get 4
                        i32.const 16
                        i32.add
                        i32.lt_u
                        select
                        local.tee 3
                        i32.const 27
                        i32.store offset=4
                        local.get 3
                        i32.const 3088
                        i64.load align=4
                        i64.store offset=16 align=4
                        local.get 3
                        i32.const 3080
                        i64.load align=4
                        i64.store offset=8 align=4
                        i32.const 3088
                        local.get 3
                        i32.const 8
                        i32.add
                        i32.store
                        i32.const 3084
                        local.get 7
                        i32.store
                        i32.const 3080
                        local.get 1
                        i32.store
                        i32.const 3092
                        i32.const 0
                        i32.store
                        local.get 3
                        i32.const 24
                        i32.add
                        local.set 0
                        loop  ;; label = @11
                          local.get 0
                          i32.const 7
                          i32.store offset=4
                          local.get 0
                          i32.const 8
                          i32.add
                          local.set 1
                          local.get 0
                          i32.const 4
                          i32.add
                          local.set 0
                          local.get 1
                          local.get 5
                          i32.lt_u
                          br_if 0 (;@11;)
                        end
                        local.get 3
                        local.get 4
                        i32.eq
                        br_if 3 (;@7;)
                        local.get 3
                        local.get 3
                        i32.load offset=4
                        i32.const -2
                        i32.and
                        i32.store offset=4
                        local.get 4
                        local.get 3
                        local.get 4
                        i32.sub
                        local.tee 5
                        i32.const 1
                        i32.or
                        i32.store offset=4
                        local.get 3
                        local.get 5
                        i32.store
                        local.get 5
                        i32.const 255
                        i32.le_u
                        if  ;; label = @11
                          local.get 5
                          i32.const 3
                          i32.shr_u
                          local.tee 1
                          i32.const 3
                          i32.shl
                          i32.const 2672
                          i32.add
                          local.set 0
                          block (result i32)  ;; label = @12
                            i32.const 2632
                            i32.load
                            local.tee 3
                            i32.const 1
                            local.get 1
                            i32.shl
                            local.tee 1
                            i32.and
                            i32.eqz
                            if  ;; label = @13
                              i32.const 2632
                              local.get 1
                              local.get 3
                              i32.or
                              i32.store
                              local.get 0
                              br 1 (;@12;)
                            end
                            local.get 0
                            i32.load offset=8
                          end
                          local.set 1
                          local.get 0
                          local.get 4
                          i32.store offset=8
                          local.get 1
                          local.get 4
                          i32.store offset=12
                          local.get 4
                          local.get 0
                          i32.store offset=12
                          local.get 4
                          local.get 1
                          i32.store offset=8
                          br 4 (;@7;)
                        end
                        i32.const 31
                        local.set 0
                        local.get 4
                        i64.const 0
                        i64.store offset=16 align=4
                        local.get 5
                        i32.const 16777215
                        i32.le_u
                        if  ;; label = @11
                          local.get 5
                          i32.const 8
                          i32.shr_u
                          local.tee 0
                          local.get 0
                          i32.const 1048320
                          i32.add
                          i32.const 16
                          i32.shr_u
                          i32.const 8
                          i32.and
                          local.tee 0
                          i32.shl
                          local.tee 1
                          local.get 1
                          i32.const 520192
                          i32.add
                          i32.const 16
                          i32.shr_u
                          i32.const 4
                          i32.and
                          local.tee 1
                          i32.shl
                          local.tee 3
                          local.get 3
                          i32.const 245760
                          i32.add
                          i32.const 16
                          i32.shr_u
                          i32.const 2
                          i32.and
                          local.tee 3
                          i32.shl
                          i32.const 15
                          i32.shr_u
                          local.get 0
                          local.get 1
                          i32.or
                          local.get 3
                          i32.or
                          i32.sub
                          local.tee 0
                          i32.const 1
                          i32.shl
                          local.get 5
                          local.get 0
                          i32.const 21
                          i32.add
                          i32.shr_u
                          i32.const 1
                          i32.and
                          i32.or
                          i32.const 28
                          i32.add
                          local.set 0
                        end
                        local.get 4
                        local.get 0
                        i32.store offset=28
                        local.get 0
                        i32.const 2
                        i32.shl
                        i32.const 2936
                        i32.add
                        local.set 1
                        block  ;; label = @11
                          i32.const 2636
                          i32.load
                          local.tee 3
                          i32.const 1
                          local.get 0
                          i32.shl
                          local.tee 7
                          i32.and
                          i32.eqz
                          if  ;; label = @12
                            i32.const 2636
                            local.get 3
                            local.get 7
                            i32.or
                            i32.store
                            local.get 1
                            local.get 4
                            i32.store
                            local.get 4
                            local.get 1
                            i32.store offset=24
                            br 1 (;@11;)
                          end
                          local.get 5
                          i32.const 0
                          i32.const 25
                          local.get 0
                          i32.const 1
                          i32.shr_u
                          i32.sub
                          local.get 0
                          i32.const 31
                          i32.eq
                          select
                          i32.shl
                          local.set 0
                          local.get 1
                          i32.load
                          local.set 1
                          loop  ;; label = @12
                            local.get 1
                            local.tee 3
                            i32.load offset=4
                            i32.const -8
                            i32.and
                            local.get 5
                            i32.eq
                            br_if 4 (;@8;)
                            local.get 0
                            i32.const 29
                            i32.shr_u
                            local.set 1
                            local.get 0
                            i32.const 1
                            i32.shl
                            local.set 0
                            local.get 3
                            local.get 1
                            i32.const 4
                            i32.and
                            i32.add
                            local.tee 7
                            i32.load offset=16
                            local.tee 1
                            br_if 0 (;@12;)
                          end
                          local.get 7
                          local.get 4
                          i32.store offset=16
                          local.get 4
                          local.get 3
                          i32.store offset=24
                        end
                        local.get 4
                        local.get 4
                        i32.store offset=12
                        local.get 4
                        local.get 4
                        i32.store offset=8
                        br 3 (;@7;)
                      end
                      local.get 4
                      i32.load offset=8
                      local.tee 0
                      local.get 6
                      i32.store offset=12
                      local.get 4
                      local.get 6
                      i32.store offset=8
                      local.get 6
                      i32.const 0
                      i32.store offset=24
                      local.get 6
                      local.get 4
                      i32.store offset=12
                      local.get 6
                      local.get 0
                      i32.store offset=8
                    end
                    local.get 9
                    i32.const 8
                    i32.add
                    local.set 0
                    br 5 (;@3;)
                  end
                  local.get 3
                  i32.load offset=8
                  local.tee 0
                  local.get 4
                  i32.store offset=12
                  local.get 3
                  local.get 4
                  i32.store offset=8
                  local.get 4
                  i32.const 0
                  i32.store offset=24
                  local.get 4
                  local.get 3
                  i32.store offset=12
                  local.get 4
                  local.get 0
                  i32.store offset=8
                end
                i32.const 2644
                i32.load
                local.tee 0
                local.get 6
                i32.le_u
                br_if 0 (;@6;)
                i32.const 2644
                local.get 0
                local.get 6
                i32.sub
                local.tee 1
                i32.store
                i32.const 2656
                i32.const 2656
                i32.load
                local.tee 0
                local.get 6
                i32.add
                local.tee 3
                i32.store
                local.get 3
                local.get 1
                i32.const 1
                i32.or
                i32.store offset=4
                local.get 0
                local.get 6
                i32.const 3
                i32.or
                i32.store offset=4
                local.get 0
                i32.const 8
                i32.add
                local.set 0
                br 3 (;@3;)
              end
              i32.const 2564
              i32.const 48
              i32.store
              i32.const 0
              local.set 0
              br 2 (;@3;)
            end
            block  ;; label = @5
              local.get 11
              i32.eqz
              br_if 0 (;@5;)
              block  ;; label = @6
                local.get 4
                i32.load offset=28
                local.tee 0
                i32.const 2
                i32.shl
                i32.const 2936
                i32.add
                local.tee 3
                i32.load
                local.get 4
                i32.eq
                if  ;; label = @7
                  local.get 3
                  local.get 1
                  i32.store
                  local.get 1
                  br_if 1 (;@6;)
                  i32.const 2636
                  local.get 9
                  i32.const -2
                  local.get 0
                  i32.rotl
                  i32.and
                  local.tee 9
                  i32.store
                  br 2 (;@5;)
                end
                local.get 11
                i32.const 16
                i32.const 20
                local.get 11
                i32.load offset=16
                local.get 4
                i32.eq
                select
                i32.add
                local.get 1
                i32.store
                local.get 1
                i32.eqz
                br_if 1 (;@5;)
              end
              local.get 1
              local.get 11
              i32.store offset=24
              local.get 4
              i32.load offset=16
              local.tee 0
              if  ;; label = @6
                local.get 1
                local.get 0
                i32.store offset=16
                local.get 0
                local.get 1
                i32.store offset=24
              end
              local.get 4
              i32.load offset=20
              local.tee 0
              i32.eqz
              br_if 0 (;@5;)
              local.get 1
              local.get 0
              i32.store offset=20
              local.get 0
              local.get 1
              i32.store offset=24
            end
            block  ;; label = @5
              local.get 5
              i32.const 15
              i32.le_u
              if  ;; label = @6
                local.get 4
                local.get 5
                local.get 6
                i32.add
                local.tee 0
                i32.const 3
                i32.or
                i32.store offset=4
                local.get 0
                local.get 4
                i32.add
                local.tee 0
                local.get 0
                i32.load offset=4
                i32.const 1
                i32.or
                i32.store offset=4
                br 1 (;@5;)
              end
              local.get 4
              local.get 6
              i32.const 3
              i32.or
              i32.store offset=4
              local.get 8
              local.get 5
              i32.const 1
              i32.or
              i32.store offset=4
              local.get 5
              local.get 8
              i32.add
              local.get 5
              i32.store
              local.get 5
              i32.const 255
              i32.le_u
              if  ;; label = @6
                local.get 5
                i32.const 3
                i32.shr_u
                local.tee 1
                i32.const 3
                i32.shl
                i32.const 2672
                i32.add
                local.set 0
                block (result i32)  ;; label = @7
                  i32.const 2632
                  i32.load
                  local.tee 3
                  i32.const 1
                  local.get 1
                  i32.shl
                  local.tee 1
                  i32.and
                  i32.eqz
                  if  ;; label = @8
                    i32.const 2632
                    local.get 1
                    local.get 3
                    i32.or
                    i32.store
                    local.get 0
                    br 1 (;@7;)
                  end
                  local.get 0
                  i32.load offset=8
                end
                local.set 1
                local.get 0
                local.get 8
                i32.store offset=8
                local.get 1
                local.get 8
                i32.store offset=12
                local.get 8
                local.get 0
                i32.store offset=12
                local.get 8
                local.get 1
                i32.store offset=8
                br 1 (;@5;)
              end
              i32.const 31
              local.set 0
              local.get 5
              i32.const 16777215
              i32.le_u
              if  ;; label = @6
                local.get 5
                i32.const 8
                i32.shr_u
                local.tee 0
                local.get 0
                i32.const 1048320
                i32.add
                i32.const 16
                i32.shr_u
                i32.const 8
                i32.and
                local.tee 0
                i32.shl
                local.tee 1
                local.get 1
                i32.const 520192
                i32.add
                i32.const 16
                i32.shr_u
                i32.const 4
                i32.and
                local.tee 1
                i32.shl
                local.tee 3
                local.get 3
                i32.const 245760
                i32.add
                i32.const 16
                i32.shr_u
                i32.const 2
                i32.and
                local.tee 3
                i32.shl
                i32.const 15
                i32.shr_u
                local.get 0
                local.get 1
                i32.or
                local.get 3
                i32.or
                i32.sub
                local.tee 0
                i32.const 1
                i32.shl
                local.get 5
                local.get 0
                i32.const 21
                i32.add
                i32.shr_u
                i32.const 1
                i32.and
                i32.or
                i32.const 28
                i32.add
                local.set 0
              end
              local.get 8
              local.get 0
              i32.store offset=28
              local.get 8
              i64.const 0
              i64.store offset=16 align=4
              local.get 0
              i32.const 2
              i32.shl
              i32.const 2936
              i32.add
              local.set 1
              block  ;; label = @6
                block  ;; label = @7
                  local.get 9
                  i32.const 1
                  local.get 0
                  i32.shl
                  local.tee 3
                  i32.and
                  i32.eqz
                  if  ;; label = @8
                    i32.const 2636
                    local.get 3
                    local.get 9
                    i32.or
                    i32.store
                    local.get 1
                    local.get 8
                    i32.store
                    br 1 (;@7;)
                  end
                  local.get 5
                  i32.const 0
                  i32.const 25
                  local.get 0
                  i32.const 1
                  i32.shr_u
                  i32.sub
                  local.get 0
                  i32.const 31
                  i32.eq
                  select
                  i32.shl
                  local.set 0
                  local.get 1
                  i32.load
                  local.set 6
                  loop  ;; label = @8
                    local.get 6
                    local.tee 1
                    i32.load offset=4
                    i32.const -8
                    i32.and
                    local.get 5
                    i32.eq
                    br_if 2 (;@6;)
                    local.get 0
                    i32.const 29
                    i32.shr_u
                    local.set 3
                    local.get 0
                    i32.const 1
                    i32.shl
                    local.set 0
                    local.get 1
                    local.get 3
                    i32.const 4
                    i32.and
                    i32.add
                    local.tee 3
                    i32.load offset=16
                    local.tee 6
                    br_if 0 (;@8;)
                  end
                  local.get 3
                  local.get 8
                  i32.store offset=16
                end
                local.get 8
                local.get 1
                i32.store offset=24
                local.get 8
                local.get 8
                i32.store offset=12
                local.get 8
                local.get 8
                i32.store offset=8
                br 1 (;@5;)
              end
              local.get 1
              i32.load offset=8
              local.tee 0
              local.get 8
              i32.store offset=12
              local.get 1
              local.get 8
              i32.store offset=8
              local.get 8
              i32.const 0
              i32.store offset=24
              local.get 8
              local.get 1
              i32.store offset=12
              local.get 8
              local.get 0
              i32.store offset=8
            end
            local.get 4
            i32.const 8
            i32.add
            local.set 0
            br 1 (;@3;)
          end
          block  ;; label = @4
            local.get 11
            i32.eqz
            br_if 0 (;@4;)
            block  ;; label = @5
              local.get 1
              i32.load offset=28
              local.tee 0
              i32.const 2
              i32.shl
              i32.const 2936
              i32.add
              local.tee 3
              i32.load
              local.get 1
              i32.eq
              if  ;; label = @6
                local.get 3
                local.get 4
                i32.store
                local.get 4
                br_if 1 (;@5;)
                i32.const 2636
                local.get 15
                i32.const -2
                local.get 0
                i32.rotl
                i32.and
                i32.store
                br 2 (;@4;)
              end
              local.get 11
              i32.const 16
              i32.const 20
              local.get 11
              i32.load offset=16
              local.get 1
              i32.eq
              select
              i32.add
              local.get 4
              i32.store
              local.get 4
              i32.eqz
              br_if 1 (;@4;)
            end
            local.get 4
            local.get 11
            i32.store offset=24
            local.get 1
            i32.load offset=16
            local.tee 0
            if  ;; label = @5
              local.get 4
              local.get 0
              i32.store offset=16
              local.get 0
              local.get 4
              i32.store offset=24
            end
            local.get 1
            i32.load offset=20
            local.tee 0
            i32.eqz
            br_if 0 (;@4;)
            local.get 4
            local.get 0
            i32.store offset=20
            local.get 0
            local.get 4
            i32.store offset=24
          end
          block  ;; label = @4
            local.get 5
            i32.const 15
            i32.le_u
            if  ;; label = @5
              local.get 1
              local.get 5
              local.get 6
              i32.add
              local.tee 0
              i32.const 3
              i32.or
              i32.store offset=4
              local.get 0
              local.get 1
              i32.add
              local.tee 0
              local.get 0
              i32.load offset=4
              i32.const 1
              i32.or
              i32.store offset=4
              br 1 (;@4;)
            end
            local.get 1
            local.get 6
            i32.const 3
            i32.or
            i32.store offset=4
            local.get 16
            local.get 5
            i32.const 1
            i32.or
            i32.store offset=4
            local.get 5
            local.get 16
            i32.add
            local.get 5
            i32.store
            local.get 9
            if  ;; label = @5
              local.get 9
              i32.const 3
              i32.shr_u
              local.tee 4
              i32.const 3
              i32.shl
              i32.const 2672
              i32.add
              local.set 0
              i32.const 2652
              i32.load
              local.set 3
              block (result i32)  ;; label = @6
                i32.const 1
                local.get 4
                i32.shl
                local.tee 4
                local.get 7
                i32.and
                i32.eqz
                if  ;; label = @7
                  i32.const 2632
                  local.get 4
                  local.get 7
                  i32.or
                  i32.store
                  local.get 0
                  br 1 (;@6;)
                end
                local.get 0
                i32.load offset=8
              end
              local.set 4
              local.get 0
              local.get 3
              i32.store offset=8
              local.get 4
              local.get 3
              i32.store offset=12
              local.get 3
              local.get 0
              i32.store offset=12
              local.get 3
              local.get 4
              i32.store offset=8
            end
            i32.const 2652
            local.get 16
            i32.store
            i32.const 2640
            local.get 5
            i32.store
          end
          local.get 1
          i32.const 8
          i32.add
          local.set 0
        end
        local.get 19
        i32.const 16
        i32.add
        global.set 0
        local.get 0
      end
      local.get 21
      call 11
      local.get 0
      local.get 13
      i32.const 16
      i32.add
      call 9
      local.get 12
      call 9
      local.get 10
      call 9
      local.tee 7
      local.set 1
      global.get 0
      i32.const 96
      i32.sub
      local.tee 0
      global.set 0
      local.get 0
      i64.const -1167088121787636991
      i64.store offset=16 align=4
      local.get 0
      i64.const 0
      i64.store offset=8 align=4
      local.get 0
      i64.const 1167088121787636990
      i64.store offset=24 align=4
      local.get 0
      i32.const 8
      i32.add
      local.get 1
      local.get 1
      call 5
      call 12
      global.get 0
      i32.const 16
      i32.sub
      local.tee 3
      global.set 0
      local.get 0
      i32.const 8
      i32.add
      local.tee 1
      i32.load
      local.set 4
      local.get 3
      i32.const 8
      i32.add
      local.get 1
      i32.const 8
      call 14
      local.get 1
      i32.const 1936
      i32.const 56
      i32.const 120
      local.get 4
      i32.const 3
      i32.shr_u
      i32.const 63
      i32.and
      local.tee 4
      i32.const 56
      i32.lt_u
      select
      local.get 4
      i32.sub
      call 12
      local.get 1
      local.get 3
      i32.const 8
      i32.add
      i32.const 8
      call 12
      local.get 13
      local.get 1
      i32.const 8
      i32.add
      i32.const 16
      call 14
      local.get 3
      i32.const 16
      i32.add
      global.set 0
      local.get 0
      i32.const 96
      i32.add
      global.set 0
      local.get 18
      i32.const 33
      call 11
      i32.const 0
      local.set 5
      global.get 0
      i32.const 16
      i32.sub
      local.tee 4
      global.set 0
      loop  ;; label = @2
        local.get 5
        i32.const 16
        i32.eq
        if  ;; label = @3
          local.get 4
          i32.const 16
          i32.add
          global.set 0
        else
          local.get 4
          i32.const 0
          i32.store8 offset=14
          local.get 4
          i32.const 0
          i32.store16 offset=12
          local.get 4
          local.get 5
          local.get 13
          i32.add
          i32.load8_u
          i32.store
          global.get 0
          i32.const 16
          i32.sub
          local.tee 6
          global.set 0
          local.get 6
          local.get 4
          i32.store offset=12
          global.get 0
          i32.const 160
          i32.sub
          local.tee 3
          global.set 0
          local.get 3
          i32.const 8
          i32.add
          i32.const 1312
          i32.const 144
          call 7
          local.get 3
          local.get 4
          i32.const 12
          i32.add
          local.tee 0
          i32.store offset=52
          local.get 3
          local.get 0
          i32.store offset=28
          local.get 3
          i32.const -2
          local.get 0
          i32.sub
          local.tee 1
          i32.const 2147483647
          local.get 1
          i32.const 2147483647
          i32.lt_u
          select
          local.tee 10
          i32.store offset=56
          local.get 3
          local.get 0
          local.get 10
          i32.add
          local.tee 0
          i32.store offset=36
          local.get 3
          local.get 0
          i32.store offset=24
          local.get 3
          i32.const 8
          i32.add
          local.set 0
          global.get 0
          i32.const 208
          i32.sub
          local.tee 1
          global.set 0
          local.get 1
          local.get 4
          i32.store offset=204
          local.get 1
          i32.const 160
          i32.add
          i32.const 0
          i32.const 40
          call 6
          drop
          local.get 1
          local.get 1
          i32.load offset=204
          i32.store offset=200
          block  ;; label = @4
            i32.const 0
            local.get 1
            i32.const 200
            i32.add
            local.get 1
            i32.const 80
            i32.add
            local.get 1
            i32.const 160
            i32.add
            call 10
            i32.const 0
            i32.lt_s
            br_if 0 (;@4;)
            local.get 0
            i32.load offset=76
            i32.const 0
            i32.ge_s
            local.set 8
            local.get 0
            i32.load
            local.set 12
            local.get 0
            i32.load8_s offset=74
            i32.const 0
            i32.le_s
            if  ;; label = @5
              local.get 0
              local.get 12
              i32.const -33
              i32.and
              i32.store
            end
            local.get 12
            i32.const 32
            i32.and
            local.set 9
            block (result i32)  ;; label = @5
              local.get 0
              i32.load offset=48
              if  ;; label = @6
                local.get 0
                local.get 1
                i32.const 200
                i32.add
                local.get 1
                i32.const 80
                i32.add
                local.get 1
                i32.const 160
                i32.add
                call 10
                br 1 (;@5;)
              end
              local.get 0
              i32.const 80
              i32.store offset=48
              local.get 0
              local.get 1
              i32.const 80
              i32.add
              i32.store offset=16
              local.get 0
              local.get 1
              i32.store offset=28
              local.get 0
              local.get 1
              i32.store offset=20
              local.get 0
              i32.load offset=44
              local.set 12
              local.get 0
              local.get 1
              i32.store offset=44
              local.get 0
              local.get 1
              i32.const 200
              i32.add
              local.get 1
              i32.const 80
              i32.add
              local.get 1
              i32.const 160
              i32.add
              call 10
              local.get 12
              i32.eqz
              br_if 0 (;@5;)
              drop
              local.get 0
              i32.const 0
              i32.const 0
              local.get 0
              i32.load offset=36
              call_indirect (type 1)
              drop
              local.get 0
              i32.const 0
              i32.store offset=48
              local.get 0
              local.get 12
              i32.store offset=44
              local.get 0
              i32.const 0
              i32.store offset=28
              local.get 0
              i32.const 0
              i32.store offset=16
              local.get 0
              i32.load offset=20
              drop
              local.get 0
              i32.const 0
              i32.store offset=20
              i32.const 0
            end
            drop
            local.get 0
            local.get 0
            i32.load
            local.get 9
            i32.or
            i32.store
            local.get 8
            i32.eqz
            br_if 0 (;@4;)
          end
          local.get 1
          i32.const 208
          i32.add
          global.set 0
          local.get 10
          if  ;; label = @4
            local.get 3
            i32.load offset=28
            local.tee 0
            local.get 0
            local.get 3
            i32.load offset=24
            i32.eq
            i32.sub
            i32.const 0
            i32.store8
          end
          local.get 3
          i32.const 160
          i32.add
          global.set 0
          local.get 6
          i32.const 16
          i32.add
          global.set 0
          local.get 18
          local.get 4
          i32.const 12
          i32.add
          call 9
          drop
          local.get 5
          i32.const 1
          i32.add
          local.set 5
          br 1 (;@2;)
        end
      end
      block  ;; label = @2
        local.get 7
        i32.eqz
        br_if 0 (;@2;)
        local.get 7
        i32.const 8
        i32.sub
        local.tee 1
        local.get 7
        i32.const 4
        i32.sub
        i32.load
        local.tee 0
        i32.const -8
        i32.and
        local.tee 3
        i32.add
        local.set 6
        block  ;; label = @3
          local.get 0
          i32.const 1
          i32.and
          br_if 0 (;@3;)
          local.get 0
          i32.const 3
          i32.and
          i32.eqz
          br_if 1 (;@2;)
          local.get 1
          local.get 1
          i32.load
          local.tee 0
          i32.sub
          local.tee 1
          i32.const 2648
          i32.load
          i32.lt_u
          br_if 1 (;@2;)
          local.get 0
          local.get 3
          i32.add
          local.set 3
          local.get 1
          i32.const 2652
          i32.load
          i32.ne
          if  ;; label = @4
            local.get 0
            i32.const 255
            i32.le_u
            if  ;; label = @5
              local.get 1
              i32.load offset=8
              local.tee 4
              local.get 0
              i32.const 3
              i32.shr_u
              local.tee 5
              i32.const 3
              i32.shl
              i32.const 2672
              i32.add
              i32.eq
              drop
              local.get 4
              local.get 1
              i32.load offset=12
              local.tee 0
              i32.eq
              if  ;; label = @6
                i32.const 2632
                i32.const 2632
                i32.load
                i32.const -2
                local.get 5
                i32.rotl
                i32.and
                i32.store
                br 3 (;@3;)
              end
              local.get 4
              local.get 0
              i32.store offset=12
              local.get 0
              local.get 4
              i32.store offset=8
              br 2 (;@3;)
            end
            local.get 1
            i32.load offset=24
            local.set 10
            block  ;; label = @5
              local.get 1
              local.get 1
              i32.load offset=12
              local.tee 0
              i32.ne
              if  ;; label = @6
                local.get 1
                i32.load offset=8
                local.tee 4
                local.get 0
                i32.store offset=12
                local.get 0
                local.get 4
                i32.store offset=8
                br 1 (;@5;)
              end
              block  ;; label = @6
                local.get 1
                i32.const 20
                i32.add
                local.tee 4
                i32.load
                local.tee 5
                br_if 0 (;@6;)
                local.get 1
                i32.const 16
                i32.add
                local.tee 4
                i32.load
                local.tee 5
                br_if 0 (;@6;)
                i32.const 0
                local.set 0
                br 1 (;@5;)
              end
              loop  ;; label = @6
                local.get 4
                local.set 7
                local.get 5
                local.tee 0
                i32.const 20
                i32.add
                local.tee 4
                i32.load
                local.tee 5
                br_if 0 (;@6;)
                local.get 0
                i32.const 16
                i32.add
                local.set 4
                local.get 0
                i32.load offset=16
                local.tee 5
                br_if 0 (;@6;)
              end
              local.get 7
              i32.const 0
              i32.store
            end
            local.get 10
            i32.eqz
            br_if 1 (;@3;)
            block  ;; label = @5
              local.get 1
              local.get 1
              i32.load offset=28
              local.tee 4
              i32.const 2
              i32.shl
              i32.const 2936
              i32.add
              local.tee 5
              i32.load
              i32.eq
              if  ;; label = @6
                local.get 5
                local.get 0
                i32.store
                local.get 0
                br_if 1 (;@5;)
                i32.const 2636
                i32.const 2636
                i32.load
                i32.const -2
                local.get 4
                i32.rotl
                i32.and
                i32.store
                br 3 (;@3;)
              end
              local.get 10
              i32.const 16
              i32.const 20
              local.get 10
              i32.load offset=16
              local.get 1
              i32.eq
              select
              i32.add
              local.get 0
              i32.store
              local.get 0
              i32.eqz
              br_if 2 (;@3;)
            end
            local.get 0
            local.get 10
            i32.store offset=24
            local.get 1
            i32.load offset=16
            local.tee 4
            if  ;; label = @5
              local.get 0
              local.get 4
              i32.store offset=16
              local.get 4
              local.get 0
              i32.store offset=24
            end
            local.get 1
            i32.load offset=20
            local.tee 4
            i32.eqz
            br_if 1 (;@3;)
            local.get 0
            local.get 4
            i32.store offset=20
            local.get 4
            local.get 0
            i32.store offset=24
            br 1 (;@3;)
          end
          local.get 6
          i32.load offset=4
          local.tee 0
          i32.const 3
          i32.and
          i32.const 3
          i32.ne
          br_if 0 (;@3;)
          i32.const 2640
          local.get 3
          i32.store
          local.get 6
          local.get 0
          i32.const -2
          i32.and
          i32.store offset=4
          local.get 1
          local.get 3
          i32.const 1
          i32.or
          i32.store offset=4
          local.get 1
          local.get 3
          i32.add
          local.get 3
          i32.store
          br 1 (;@2;)
        end
        local.get 1
        local.get 6
        i32.ge_u
        br_if 0 (;@2;)
        local.get 6
        i32.load offset=4
        local.tee 0
        i32.const 1
        i32.and
        i32.eqz
        br_if 0 (;@2;)
        block  ;; label = @3
          local.get 0
          i32.const 2
          i32.and
          i32.eqz
          if  ;; label = @4
            local.get 6
            i32.const 2656
            i32.load
            i32.eq
            if  ;; label = @5
              i32.const 2656
              local.get 1
              i32.store
              i32.const 2644
              i32.const 2644
              i32.load
              local.get 3
              i32.add
              local.tee 0
              i32.store
              local.get 1
              local.get 0
              i32.const 1
              i32.or
              i32.store offset=4
              local.get 1
              i32.const 2652
              i32.load
              i32.ne
              br_if 3 (;@2;)
              i32.const 2640
              i32.const 0
              i32.store
              i32.const 2652
              i32.const 0
              i32.store
              br 3 (;@2;)
            end
            local.get 6
            i32.const 2652
            i32.load
            i32.eq
            if  ;; label = @5
              i32.const 2652
              local.get 1
              i32.store
              i32.const 2640
              i32.const 2640
              i32.load
              local.get 3
              i32.add
              local.tee 0
              i32.store
              local.get 1
              local.get 0
              i32.const 1
              i32.or
              i32.store offset=4
              local.get 0
              local.get 1
              i32.add
              local.get 0
              i32.store
              br 3 (;@2;)
            end
            local.get 0
            i32.const -8
            i32.and
            local.get 3
            i32.add
            local.set 3
            block  ;; label = @5
              local.get 0
              i32.const 255
              i32.le_u
              if  ;; label = @6
                local.get 6
                i32.load offset=8
                local.tee 4
                local.get 0
                i32.const 3
                i32.shr_u
                local.tee 5
                i32.const 3
                i32.shl
                i32.const 2672
                i32.add
                i32.eq
                drop
                local.get 4
                local.get 6
                i32.load offset=12
                local.tee 0
                i32.eq
                if  ;; label = @7
                  i32.const 2632
                  i32.const 2632
                  i32.load
                  i32.const -2
                  local.get 5
                  i32.rotl
                  i32.and
                  i32.store
                  br 2 (;@5;)
                end
                local.get 4
                local.get 0
                i32.store offset=12
                local.get 0
                local.get 4
                i32.store offset=8
                br 1 (;@5;)
              end
              local.get 6
              i32.load offset=24
              local.set 10
              block  ;; label = @6
                local.get 6
                local.get 6
                i32.load offset=12
                local.tee 0
                i32.ne
                if  ;; label = @7
                  local.get 6
                  i32.load offset=8
                  local.tee 4
                  i32.const 2648
                  i32.load
                  i32.lt_u
                  drop
                  local.get 4
                  local.get 0
                  i32.store offset=12
                  local.get 0
                  local.get 4
                  i32.store offset=8
                  br 1 (;@6;)
                end
                block  ;; label = @7
                  local.get 6
                  i32.const 20
                  i32.add
                  local.tee 4
                  i32.load
                  local.tee 5
                  br_if 0 (;@7;)
                  local.get 6
                  i32.const 16
                  i32.add
                  local.tee 4
                  i32.load
                  local.tee 5
                  br_if 0 (;@7;)
                  i32.const 0
                  local.set 0
                  br 1 (;@6;)
                end
                loop  ;; label = @7
                  local.get 4
                  local.set 7
                  local.get 5
                  local.tee 0
                  i32.const 20
                  i32.add
                  local.tee 4
                  i32.load
                  local.tee 5
                  br_if 0 (;@7;)
                  local.get 0
                  i32.const 16
                  i32.add
                  local.set 4
                  local.get 0
                  i32.load offset=16
                  local.tee 5
                  br_if 0 (;@7;)
                end
                local.get 7
                i32.const 0
                i32.store
              end
              local.get 10
              i32.eqz
              br_if 0 (;@5;)
              block  ;; label = @6
                local.get 6
                local.get 6
                i32.load offset=28
                local.tee 4
                i32.const 2
                i32.shl
                i32.const 2936
                i32.add
                local.tee 5
                i32.load
                i32.eq
                if  ;; label = @7
                  local.get 5
                  local.get 0
                  i32.store
                  local.get 0
                  br_if 1 (;@6;)
                  i32.const 2636
                  i32.const 2636
                  i32.load
                  i32.const -2
                  local.get 4
                  i32.rotl
                  i32.and
                  i32.store
                  br 2 (;@5;)
                end
                local.get 10
                i32.const 16
                i32.const 20
                local.get 10
                i32.load offset=16
                local.get 6
                i32.eq
                select
                i32.add
                local.get 0
                i32.store
                local.get 0
                i32.eqz
                br_if 1 (;@5;)
              end
              local.get 0
              local.get 10
              i32.store offset=24
              local.get 6
              i32.load offset=16
              local.tee 4
              if  ;; label = @6
                local.get 0
                local.get 4
                i32.store offset=16
                local.get 4
                local.get 0
                i32.store offset=24
              end
              local.get 6
              i32.load offset=20
              local.tee 4
              i32.eqz
              br_if 0 (;@5;)
              local.get 0
              local.get 4
              i32.store offset=20
              local.get 4
              local.get 0
              i32.store offset=24
            end
            local.get 1
            local.get 3
            i32.const 1
            i32.or
            i32.store offset=4
            local.get 1
            local.get 3
            i32.add
            local.get 3
            i32.store
            local.get 1
            i32.const 2652
            i32.load
            i32.ne
            br_if 1 (;@3;)
            i32.const 2640
            local.get 3
            i32.store
            br 2 (;@2;)
          end
          local.get 6
          local.get 0
          i32.const -2
          i32.and
          i32.store offset=4
          local.get 1
          local.get 3
          i32.const 1
          i32.or
          i32.store offset=4
          local.get 1
          local.get 3
          i32.add
          local.get 3
          i32.store
        end
        local.get 3
        i32.const 255
        i32.le_u
        if  ;; label = @3
          local.get 3
          i32.const 3
          i32.shr_u
          local.tee 3
          i32.const 3
          i32.shl
          i32.const 2672
          i32.add
          local.set 0
          block (result i32)  ;; label = @4
            i32.const 2632
            i32.load
            local.tee 4
            i32.const 1
            local.get 3
            i32.shl
            local.tee 3
            i32.and
            i32.eqz
            if  ;; label = @5
              i32.const 2632
              local.get 3
              local.get 4
              i32.or
              i32.store
              local.get 0
              br 1 (;@4;)
            end
            local.get 0
            i32.load offset=8
          end
          local.set 3
          local.get 0
          local.get 1
          i32.store offset=8
          local.get 3
          local.get 1
          i32.store offset=12
          local.get 1
          local.get 0
          i32.store offset=12
          local.get 1
          local.get 3
          i32.store offset=8
          br 1 (;@2;)
        end
        i32.const 31
        local.set 4
        local.get 1
        i64.const 0
        i64.store offset=16 align=4
        local.get 3
        i32.const 16777215
        i32.le_u
        if  ;; label = @3
          local.get 3
          i32.const 8
          i32.shr_u
          local.tee 0
          local.get 0
          i32.const 1048320
          i32.add
          i32.const 16
          i32.shr_u
          i32.const 8
          i32.and
          local.tee 0
          i32.shl
          local.tee 4
          local.get 4
          i32.const 520192
          i32.add
          i32.const 16
          i32.shr_u
          i32.const 4
          i32.and
          local.tee 4
          i32.shl
          local.tee 5
          local.get 5
          i32.const 245760
          i32.add
          i32.const 16
          i32.shr_u
          i32.const 2
          i32.and
          local.tee 5
          i32.shl
          i32.const 15
          i32.shr_u
          local.get 0
          local.get 4
          i32.or
          local.get 5
          i32.or
          i32.sub
          local.tee 0
          i32.const 1
          i32.shl
          local.get 3
          local.get 0
          i32.const 21
          i32.add
          i32.shr_u
          i32.const 1
          i32.and
          i32.or
          i32.const 28
          i32.add
          local.set 4
        end
        local.get 1
        local.get 4
        i32.store offset=28
        local.get 4
        i32.const 2
        i32.shl
        i32.const 2936
        i32.add
        local.set 0
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              i32.const 2636
              i32.load
              local.tee 5
              i32.const 1
              local.get 4
              i32.shl
              local.tee 7
              i32.and
              i32.eqz
              if  ;; label = @6
                i32.const 2636
                local.get 5
                local.get 7
                i32.or
                i32.store
                local.get 0
                local.get 1
                i32.store
                local.get 1
                local.get 0
                i32.store offset=24
                br 1 (;@5;)
              end
              local.get 3
              i32.const 0
              i32.const 25
              local.get 4
              i32.const 1
              i32.shr_u
              i32.sub
              local.get 4
              i32.const 31
              i32.eq
              select
              i32.shl
              local.set 4
              local.get 0
              i32.load
              local.set 0
              loop  ;; label = @6
                local.get 0
                local.tee 5
                i32.load offset=4
                i32.const -8
                i32.and
                local.get 3
                i32.eq
                br_if 2 (;@4;)
                local.get 4
                i32.const 29
                i32.shr_u
                local.set 0
                local.get 4
                i32.const 1
                i32.shl
                local.set 4
                local.get 5
                local.get 0
                i32.const 4
                i32.and
                i32.add
                local.tee 7
                i32.load offset=16
                local.tee 0
                br_if 0 (;@6;)
              end
              local.get 7
              local.get 1
              i32.store offset=16
              local.get 1
              local.get 5
              i32.store offset=24
            end
            local.get 1
            local.get 1
            i32.store offset=12
            local.get 1
            local.get 1
            i32.store offset=8
            br 1 (;@3;)
          end
          local.get 5
          i32.load offset=8
          local.tee 0
          local.get 1
          i32.store offset=12
          local.get 5
          local.get 1
          i32.store offset=8
          local.get 1
          i32.const 0
          i32.store offset=24
          local.get 1
          local.get 5
          i32.store offset=12
          local.get 1
          local.get 0
          i32.store offset=8
        end
        i32.const 2664
        i32.const 2664
        i32.load
        i32.const 1
        i32.sub
        local.tee 0
        i32.const -1
        local.get 0
        select
        i32.store
      end
      local.get 13
      i32.const 128
      i32.add
      global.set 0
      loop  ;; label = @2
        local.get 14
        i32.const 32
        i32.eq
        if  ;; label = @3
          local.get 2
          i32.const 0
          i32.store8 offset=32
        else
          local.get 2
          local.get 14
          i32.add
          local.get 14
          local.get 20
          i32.add
          i32.load8_u
          i32.store8
          local.get 14
          i32.const 1
          i32.add
          local.set 14
          br 1 (;@2;)
        end
      end
    end
    local.get 17
    i32.const 48
    i32.add
    global.set 0
    local.get 2)
  (func (;22;) (type 0) (param i32) (result i32)
    global.get 0
    local.get 0
    i32.sub
    i32.const -16
    i32.and
    local.tee 0
    global.set 0
    local.get 0)
  (func (;23;) (type 10) (param i32)
    local.get 0
    global.set 0)
  (func (;24;) (type 4) (result i32)
    global.get 0)
  (table (;0;) 2 2 funcref)
  (memory (;0;) 256 256)
  (global (;0;) (mut i32) (i32.const 5246016))
  (export "c" (memory 0))
  (export "d" (func 13))
  (export "e" (func 21))
  (export "f" (func 20))
  (export "g" (table 0))
  (export "h" (func 24))
  (export "i" (func 23))
  (export "j" (func 22))
  (elem (;0;) (i32.const 1) func 19)
  (data (;0;) (i32.const 1024) "2\00\00\005\00\00\00d\00\00\006\00\00\003\00\00\004\00\00\00b\00\00\00c\00\00\001\00\00\00b\00\00\003\00\00\009\00\00\00e\00\00\001\00\00\001\00\00\001\00\00\002\00\00\009\00\00\00f\00\00\00b\00\00\00e\00\00\003\00\00\007\00\00\00a\00\00\008\00\00\00c\00\00\00f\00\00\00f\00\00\007\00\00\00e\00\00\001\00\00\008\00\00\00%02x\00-+   0X0x\00(null)")
  (data (;1;) (i32.const 1184) "Y\00\00\001\00\00\00M\00\00\00B\00\00\00b\00\00\00j\00\00\00t\00\00\00N\00\00\00w\00\00\004\00\00\00i\00\00\00b\00\00\00P\00\00\00H\00\00\00f\00\00\00g\00\00\00R\00\00\008\00\00\00z\00\00\00x\00\00\00e\00\00\00w\00\00\009\00\00\00H\00\00\00I\00\00\00M\00\00\00U\00\00\00w\00\00\00J\00\00\00v\00\00\000\00\00\003")
  (data (;2;) (i32.const 1348) "\01")
  (data (;3;) (i32.const 1387) "\ff\ff\ff\ff\ff")
  (data (;4;) (i32.const 1456) "\11\00\0a\00\11\11\11\00\00\00\00\05\00\00\00\00\00\00\09\00\00\00\00\0b\00\00\00\00\00\00\00\00\11\00\0f\0a\11\11\11\03\0a\07\00\01\00\09\0b\0b\00\00\09\06\0b\00\00\0b\00\06\11\00\00\00\11\11\11")
  (data (;5;) (i32.const 1537) "\0b\00\00\00\00\00\00\00\00\11\00\0a\0a\11\11\11\00\0a\00\00\02\00\09\0b\00\00\00\09\00\0b\00\00\0b")
  (data (;6;) (i32.const 1595) "\0c")
  (data (;7;) (i32.const 1607) "\0c\00\00\00\00\0c\00\00\00\00\09\0c\00\00\00\00\00\0c\00\00\0c")
  (data (;8;) (i32.const 1653) "\0e")
  (data (;9;) (i32.const 1665) "\0d\00\00\00\04\0d\00\00\00\00\09\0e\00\00\00\00\00\0e\00\00\0e")
  (data (;10;) (i32.const 1711) "\10")
  (data (;11;) (i32.const 1723) "\0f\00\00\00\00\0f\00\00\00\00\09\10\00\00\00\00\00\10\00\00\10\00\00\12\00\00\00\12\12\12")
  (data (;12;) (i32.const 1778) "\12\00\00\00\12\12\12\00\00\00\00\00\00\09")
  (data (;13;) (i32.const 1827) "\0b")
  (data (;14;) (i32.const 1839) "\0a\00\00\00\00\0a\00\00\00\00\09\0b\00\00\00\00\00\0b\00\00\0b")
  (data (;15;) (i32.const 1885) "\0c")
  (data (;16;) (i32.const 1897) "\0c\00\00\00\00\0c\00\00\00\00\09\0c\00\00\00\00\00\0c\00\00\0c\00\000123456789ABCDEF")
  (data (;17;) (i32.const 1936) "\80")
  (data (;18;) (i32.const 2172) "0\0a")
  (data (;19;) (i32.const 2228) "@\0cP"))
