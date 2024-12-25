using Test
using GVec 

@testset "GVec" begin

    # Test Vec2
    v = Vec2(1.0, 2.0)
  
    # Test indexing
    @test v[1] == 1.0
    @test v[2] == 2.0
    v[1] = 3.0
    @test v[1] == 3.0
  
    # Test dot product
    v1 = Vec2(1.0, 2.0)
    v2 = Vec2(3.0, 4.0)
    @test dot(v1, v2) == 11.0
  
    # Test norm
    @test norm(v1) ≈ sqrt(5.0)
  
    # Test normalize
    v_norm = normalize(v1)
    @test norm(v_norm) ≈ 1.0
  
    # Test cross product
    @test cross(v1, v2) == -2.0
  
    # Test arithmetic operations
    @test v1 + v2 == Vec2(4.0, 6.0)
    @test v2 - v1 == Vec2(2.0, 2.0)
    @test 2.0 * v1 == Vec2(2.0, 4.0)
    2.0 * v1 == Vec2(2.0, 4.0)
    @test v1 * 2.0 == Vec2(2.0, 4.0)
    @test v1 / 2.0 == Vec2(0.5, 1.0)
  
    # Test comparison operations
    @test v1 == Vec2(1.0, 2.0)
    @test v1 != v2
  

    # Test printing
    io = IOBuffer()
    print(io, Vec2(1.0, 2.0))
    @test String(take!(io)) == "Vec2{Float64}(1.0, 2.0)"

    # Test Vec3
    v3 = Vec3(1.0, 2.0, 3.0)

    # Test indexing
    @test v3[1] == 1.0
    @test v3[2] == 2.0
    @test v3[3] == 3.0
    v3[1] = 4.0
    @test v3[1] == 4.0
   
    # Test dot product
    v3_1 = Vec3(1.0, 2.0, 3.0)
    v3_2 = Vec3(4.0, 5.0, 6.0)
    @test dot(v3_1, v3_2) == 32.0
   
    # Test norm
    @test norm(v3_1) ≈ sqrt(14.0)
   
    # Test normalize
    v3_norm = normalize(v3_1)
    @test norm(v3_norm) ≈ 1.0
   
    # Test cross product
    @test cross(v3_1, v3_2) == Vec3(-3.0, 6.0, -3.0)
   
    # Test arithmetic operations
    @test v3_1 + v3_2 == Vec3(5.0, 7.0, 9.0)
    @test v3_2 - v3_1 == Vec3(3.0, 3.0, 3.0)
    @test 2.0 * v3_1 == Vec3(2.0, 4.0, 6.0)
    @test v3_1 * 2.0 == Vec3(2.0, 4.0, 6.0)
    @test v3_1 / 2.0 == Vec3(0.5, 1.0, 1.5)
   
    # Test comparison operations
    @test v3_1 == Vec3(1.0, 2.0, 3.0)
    @test v3_1 != v3_2
   
    # Test printing
    io = IOBuffer()
    print(io, Vec3(1.0, 2.0, 3.0))
    @test String(take!(io)) == "Vec3{Float64}(1.0, 2.0, 3.0)"
   
   
    # Test Vec4
    v4 = Vec4(1.0, 2.0, 3.0, 4.0)
   
    # Test indexing
    @test v4[1] == 1.0
    @test v4[2] == 2.0
    @test v4[3] == 3.0
    @test v4[4] == 4.0
    v4[1] = 5.0
    @test v4[1] == 5.0
   
    # Test dot product
    v4_1 = Vec4(1.0, 2.0, 3.0, 4.0)
    v4_2 = Vec4(5.0, 6.0, 7.0, 8.0)
    @test dot(v4_1, v4_2) == 70.0
   
    # Test norm
    @test norm(v4_1) ≈ sqrt(30.0)
   
    # Test normalize
    v4_norm = normalize(v4_1)
    @test norm(v4_norm) ≈ 1.0
   
    # Test arithmetic operations
    @test v4_1 + v4_2 == Vec4(6.0, 8.0, 10.0, 12.0)
    @test v4_2 - v4_1 == Vec4(4.0, 4.0, 4.0, 4.0)
    @test 2.0 * v4_1 == Vec4(2.0, 4.0, 6.0, 8.0)
    @test v4_1 * 2.0 == Vec4(2.0, 4.0, 6.0, 8.0)
    @test v4_1 / 2.0 == Vec4(0.5, 1.0, 1.5, 2.0)
   
    # Test comparison operations
    @test v4_1 == Vec4(1.0, 2.0, 3.0, 4.0)
    @test v4_1 != v4_2
   
    # Test printing
    io = IOBuffer()
    print(io, Vec4(1.0, 2.0, 3.0, 4.0))
    @test String(take!(io)) == "Vec4{Float64}(1.0, 2.0, 3.0, 4.0)"
end

@testset "Matrix Tests" begin
     # Test Mat2 operations
     m2 = Mat2(1.0, 2.0, 3.0, 4.0)
     m2_2 = Mat2(2.0, 3.0, 4.0, 5.0)
     
     # Basic arithmetic
     @test (m2 + m2_2) == [3.0 5.0; 7.0 9.0]
     @test (m2 - m2_2) == [-1.0 -1.0; -1.0 -1.0]
     @test (m2 * 2.0) == [2.0 4.0; 6.0 8.0]
     @test (m2 / 2.0) == [0.5 1.0; 1.5 2.0]
 
     # Determinant, trace, and inverse
     @test determinant(m2) == -2.0
     @test trace(m2) == 5.0
     #@test (inverse(m2)) ≈ Mat2(-2.0, 1.0, 1.5, -0.5)
 
     # Test Mat3 operations
     m3 = Mat3(1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0)
     m3_2 = Mat3(9.0, 8.0, 7.0, 6.0, 5.0, 4.0, 3.0, 2.0, 1.0)
 
     # Basic arithmetic
     @test (m3 + m3_2) == [10.0 10.0 10.0; 10.0 10.0 10.0; 10.0 10.0 10.0]
     @test (m3 - m3_2) == [-8.0 -6.0 -4.0; -2.0 0.0 2.0; 4.0 6.0 8.0]
 
     # Determinant, trace, and inverse
     @test determinant(m3) == 0.0  # Singular matrix
     @test trace(m3) == 15.0
     @test_throws ArgumentError inverse(m3)  # Cannot invert singular matrix
 
     # Test Mat4 operations
     m4 = Mat4(1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0)
 
     # Determinant and trace
     @test determinant(m4) == 0.0  # Singular matrix
     @test trace(m4) == 34.0
 
     # Test vector-matrix multiplication
     v2 = Vec2(1.0, 2.0)
     v3 = Vec3(1.0, 2.0, 3.0)
     v4 = Vec4(1.0, 2.0, 3.0, 4.0)
 
     @test m2 * v2 == Vec2(5.0, 11.0)
     @test v2 * m2 == Vec2(7.0, 10.0)
 
     m3_v3 = Mat3(1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0)
     @test m3_v3 * v3 == Vec3(14.0, 32.0, 50.0)
     @test v3 * m3_v3 == Vec3(30.0, 36.0, 42.0)
 
     m4_v4 = Mat4(1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0)
     @test m4_v4 * v4 == Vec4(30.0, 70.0, 110.0, 150.0)
     @test v4 * m4_v4 == Vec4(90.0, 100.0, 110.0, 120.0)
end