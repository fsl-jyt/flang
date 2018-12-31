! Copyright (c) 2018, NVIDIA CORPORATION.  All rights reserved.
!
! Licensed under the Apache License, Version 2.0 (the "License");
! you may not use this file except in compliance with the License.
! You may obtain a copy of the License at
!
!     http://www.apache.org/licenses/LICENSE-2.0
!
! Unless required by applicable law or agreed to in writing, software
! distributed under the License is distributed on an "AS IS" BASIS,
! WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
! See the License for the specific language governing permissions and
! limitations under the License.

MODULE m
  INTERFACE
    MODULE SUBROUTINE sub1(arg1)
      INTEGER, intent(inout) :: arg1
    END SUBROUTINE

    MODULE SUBROUTINE sub2(arg2)
      INTEGER, intent(inout) :: arg2
    END SUBROUTINE

    INTEGER MODULE FUNCTION F1(ARG1)
      INTEGER, INTENT(INOUT) :: ARG1
    END FUNCTION
  END INTERFACE
END MODULE

SUBMODULE (m) n
INTERFACE
  MODULE SUBROUTINE SUB3(ARG3)
    INTEGER, INTENT(INOUT) :: ARG3
  END SUBROUTINE
END INTERFACE

  CONTAINS
    MODULE SUBROUTINE sub1(arg1) !{error "PGF90-S-1058-The type of definition argument arg1 does not match its declaration type"}
      REAL, intent(inout) :: arg1
    END SUBROUTINE sub1
END SUBMODULE

SUBMODULE (m:n) k
  CONTAINS
    MODULE SUBROUTINE sub2(arg2) !{error "PGF90-S-1058-The type of definition argument arg2 does not match its declaration type"}
      REAL, intent(inout) :: arg2
    END SUBROUTINE sub2

    MODULE SUBROUTINE SUB3(ARG3) !{error "PGF90-S-1058-The type of definition argument arg3 does not match its declaration type"}
      REAL, INTENT(INOUT) :: ARG3
    END SUBROUTINE

    INTEGER MODULE FUNCTION F1(ARG1) !{error "PGF90-S-1058-The type of definition argument arg1 does not match its declaration type"}
      REAL, INTENT(INOUT) :: ARG1
    END FUNCTION
END SUBMODULE

