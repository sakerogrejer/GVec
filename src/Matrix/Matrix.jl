# Matrixl.jl
"""
A 2x2 matrix type. [p00 p01
                    p10 p11]
"""
struct Mat2{T}
    p00::T; p01::T
    p10::T; p11::T
end

"""
A 3x3 matrix type. [p00 p01 p02
                    p10 p11 p12
                    p20 p21 p22]
"""
struct Mat3{T}
    p00::T; p01::T; p02::T
    p10::T; p11::T; p12::T
    p20::T; p21::T; p22::T
end

"""
A 4x4 matrix type. [p00 p01 p02 p03
                    p10 p11 p12 p13
                    p20 p21 p22 p23
                    p30 p31 p32 p33]
"""
struct Mat4{T}
    p00::T; p01::T; p02::T; p03::T
    p10::T; p11::T; p12::T; p13::T
    p20::T; p21::T; p22::T; p23::T
    p30::T; p31::T; p32::T; p33::T
end

# Convert to julia matrix for easy math
function to_matrix(m::Mat2)
    return [m.p00 m.p01; m.p10 m.p11]
end

function to_matrix(m::Mat3)
    return [m.p00 m.p01 m.p02; m.p10 m.p11 m.p12; m.p20 m.p21 m.p22]
end

function to_matrix(m::Mat4)
    return [m.p00 m.p01 m.p02 m.p03; m.p10 m.p11 m.p12 m.p13; m.p20 m.p21 m.p22 m.p23; m.p30 m.p31 m.p32 m.p33]
end

# Overload the + operator
Base.:+(m1::Mat2, m2::Mat2) = to_matrix(m1) .+ to_matrix(m2)
Base.:+(m1::Mat3, m2::Mat3) = to_matrix(m1) .+ to_matrix(m2)
Base.:+(m1::Mat4, m2::Mat4) = to_matrix(m1) .+ to_matrix(m2)

# Overload the - operator
Base.:-(m1::Mat2, m2::Mat2) = to_matrix(m1) .- to_matrix(m2)
Base.:-(m1::Mat3, m2::Mat3) = to_matrix(m1) .- to_matrix(m2)
Base.:-(m1::Mat4, m2::Mat4) = to_matrix(m1) .- to_matrix(m2)

# Overload the * operator
Base.:*(m::Mat2, s::Number) = to_matrix(m) .* s
Base.:*(s::Number, m::Mat2) = to_matrix(m) .* s
Base.:*(m::Mat3, s::Number) = to_matrix(m) .* s
Base.:*(s::Number, m::Mat3) = to_matrix(m) .* s
Base.:*(m::Mat4, s::Number) = to_matrix(m) .* s
Base.:*(s::Number, m::Mat4) = to_matrix(m) .* s

Base.:*(m1::Mat2, m2::Mat2) = to_matrix(m1) * to_matrix(m2)
Base.:*(m1::Mat3, m2::Mat3) = to_matrix(m1) * to_matrix(m2)
Base.:*(m1::Mat4, m2::Mat4) = to_matrix(m1) * to_matrix(m2)

# Overload the / operator
Base.:/(m::Mat2, s::Number) = to_matrix(m) ./ s
Base.:/(m::Mat3, s::Number) = to_matrix(m) ./ s
Base.:/(m::Mat4, s::Number) = to_matrix(m) ./ s

Base.:≈(m1::Mat2, m2::Mat2) = isapprox(to_matrix(m1), to_matrix(m2))

# Determinant calculation
function determinant(m::Mat2)
    m.p00 * m.p11 - m.p01 * m.p10
end

function determinant(m::Mat3)
    m.p00 * (m.p11 * m.p22 - m.p12 * m.p21) -
    m.p01 * (m.p10 * m.p22 - m.p12 * m.p20) +
    m.p02 * (m.p10 * m.p21 - m.p11 * m.p20)
end

function determinant(m::Mat4)
    matrix = to_matrix(m)
    det = 0.0
    for i in 1:4
        minor = matrix[2:end, [1:i-1; i+1:end]]
        det += (-1)^(1+i) * matrix[1, i] * determinant(Mat3(minor[1,1], minor[1,2], minor[1,3],
                                                           minor[2,1], minor[2,2], minor[2,3],
                                                           minor[3,1], minor[3,2], minor[3,3]))
    end
    return det
end

# Matrix inversion (only for Mat2 and Mat3)
function inverse(m::Mat2)
    det = determinant(m)
    det == 0 && throw(ArgumentError("Matrix is singular and cannot be inverted."))
    Mat2(
        m.p11 / det, -m.p01 / det,
        -m.p10 / det, m.p00 / det
    )
end

function inverse(m::Mat3)
    det = determinant(m)
    det == 0 && throw(ArgumentError("Matrix is singular and cannot be inverted."))
    matrix = to_matrix(m)
    cofactor_matrix = zeros(eltype(m.p00), 3, 3)
    for i in 1:3, j in 1:3
        minor = matrix[[1:i-1; i+1:3], [1:j-1; j+1:3]]
        cofactor_matrix[j, i] = (-1)^(i + j) * determinant(Mat2(minor[1,1], minor[1,2],
                                                                minor[2,1], minor[2,2]))
    end
    return Mat3(cofactor_matrix / det)
end

# Trace calculation
function trace(m::Mat2)
    m.p00 + m.p11
end

function trace(m::Mat3)
    m.p00 + m.p11 + m.p22
end

function trace(m::Mat4)
    m.p00 + m.p11 + m.p22 + m.p33
end

# Approximation check for matrices
function isapprox(m1::Mat2, m2::Mat2; atol::Real = 1e-8, rtol::Real = 1e-8)
    isapprox(m1.p00, m2.p00; atol=atol, rtol=rtol) &&
    isapprox(m1.p01, m2.p01; atol=atol, rtol=rtol) &&
    isapprox(m1.p10, m2.p10; atol=atol, rtol=rtol) &&
    isapprox(m1.p11, m2.p11; atol=atol, rtol=rtol)
end

function isapprox(m1::Mat3, m2::Mat3; atol::Real = 1e-8, rtol::Real = 1e-8)
    isapprox(m1.p00, m2.p00; atol=atol, rtol=rtol) &&
    isapprox(m1.p01, m2.p01; atol=atol, rtol=rtol) &&
    isapprox(m1.p02, m2.p02; atol=atol, rtol=rtol) &&
    isapprox(m1.p10, m2.p10; atol=atol, rtol=rtol) &&
    isapprox(m1.p11, m2.p11; atol=atol, rtol=rtol) &&
    isapprox(m1.p12, m2.p12; atol=atol, rtol=rtol) &&
    isapprox(m1.p20, m2.p20; atol=atol, rtol=rtol) &&
    isapprox(m1.p21, m2.p21; atol=atol, rtol=rtol) &&
    isapprox(m1.p22, m2.p22; atol=atol, rtol=rtol)
end

function isapprox(m1::Mat4, m2::Mat4; atol::Real = 1e-8, rtol::Real = 1e-8)
    isapprox(m1.p00, m2.p00; atol=atol, rtol=rtol) &&
    isapprox(m1.p01, m2.p01; atol=atol, rtol=rtol) &&
    isapprox(m1.p02, m2.p02; atol=atol, rtol=rtol) &&
    isapprox(m1.p03, m2.p03; atol=atol, rtol=rtol) &&
    isapprox(m1.p10, m2.p10; atol=atol, rtol=rtol) &&
    isapprox(m1.p11, m2.p11; atol=atol, rtol=rtol) &&
    isapprox(m1.p12, m2.p12; atol=atol, rtol=rtol) &&
    isapprox(m1.p13, m2.p13; atol=atol, rtol=rtol) &&
    isapprox(m1.p20, m2.p20; atol=atol, rtol=rtol) &&
    isapprox(m1.p21, m2.p21; atol=atol, rtol=rtol) &&
    isapprox(m1.p22, m2.p22; atol=atol, rtol=rtol) &&
    isapprox(m1.p23, m2.p23; atol=atol, rtol=rtol) &&
    isapprox(m1.p30, m2.p30; atol=atol, rtol=rtol) &&
    isapprox(m1.p31, m2.p31; atol=atol, rtol=rtol) &&
    isapprox(m1.p32, m2.p32; atol=atol, rtol=rtol) &&
    isapprox(m1.p33, m2.p33; atol=atol, rtol=rtol)
end

function orthographic_projection(l, r, b, t, n, f)
    return Mat4(
        2 / (r - l), 0, 0, -(r + l) / (r - l),
        0, 2 / (t - b), 0, -(t + b) / (t - b),
        0, 0, -2 / (f - n), -(f + n) / (f - n),
        0, 0, 0, 1
    )
end

function perspective_projection(fov, aspect, n, f)
    s = 1 / tan(fov / 2)
    return Mat4(
        s / aspect, 0, 0, 0,
        0, s, 0, 0,
        0, 0, -(f + n) / (f - n), -2 * f * n / (f - n),
        0, 0, -1, 0
    )
end

function scale(sx, sy)
    Mat2(sx, 0.0, 0.0, sy)
end

function scale(sx, sy, sz)
    Mat3(sx, 0.0, 0.0, 0.0, sy, 0.0, 0.0, 0.0, sz)
end

function rot2(angle)
    c = cos(angle)
    s = sin(angle)
    Mat2(c, -s, s, c)
end

function rot3x(angle)
    c = cos(angle)
    s = sin(angle)
    Mat3(1.0, 0.0, 0.0, 0.0, c, -s, 0.0, s, c)
end

function rot3y(angle)
    c = cos(angle)
    s = sin(angle)
    Mat3(c, 0.0, s, 0.0, 1.0, 0.0, -s, 0.0, c)
end

function rot3z(angle)
    c = cos(angle)
    s = sin(angle)
    Mat3(c, -s, 0.0, s, c, 0.0, 0.0, 0.0, 1.0)
end

function tform2(tx, ty)
    Mat3(1.0, 0.0, tx, 0.0, 1.0, ty, 0.0, 0.0, 1.0)
end

function tform3(tx, ty, tz)
    Mat4(1.0, 0.0, 0.0, tx, 0.0, 1.0, 0.0, ty, 0.0, 0.0, 1.0, tz, 0.0, 0.0, 0.0, 1.0)
end

function xform3(tx, ty, tz, angle_x, angle_y, angle_z, sx, sy, sz)
    # Scaling matrix
    scale_mat = Mat4(
        sx, 0.0, 0.0, 0.0,
        0.0, sy, 0.0, 0.0,
        0.0, 0.0, sz, 0.0,
        0.0, 0.0, 0.0, 1.0
    )

    # Rotation matrices
    cx, sx = cos(angle_x), sin(angle_x)
    cy, sy = cos(angle_y), sin(angle_y)
    cz, sz = cos(angle_z), sin(angle_z)

    rot_x_mat = Mat4(
        1.0, 0.0, 0.0, 0.0,
        0.0, cx, -sx, 0.0,
        0.0, sx, cx, 0.0,
        0.0, 0.0, 0.0, 1.0
    )

    rot_y_mat = Mat4(
        cy, 0.0, sy, 0.0,
        0.0, 1.0, 0.0, 0.0,
        -sy, 0.0, cy, 0.0,
        0.0, 0.0, 0.0, 1.0
    )

    rot_z_mat = Mat4(
        cz, -sz, 0.0, 0.0,
        sz, cz, 0.0, 0.0,
        0.0, 0.0, 1.0, 0.0,
        0.0, 0.0, 0.0, 1.0
    )

    # Translation matrix
    translation_mat = Mat4(
        1.0, 0.0, 0.0, tx,
        0.0, 1.0, 0.0, ty,
        0.0, 0.0, 1.0, tz,
        0.0, 0.0, 0.0, 1.0
    )

    # Combined matrix: T * Rz * Ry * Rx * S
    combined_mat = translation_mat * rot_z_mat * rot_y_mat * rot_x_mat * scale_mat

    return combined_mat
end
